import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter/material.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'dart:io' show Platform;
import 'dart:async';
import 'dart:isolate';
import 'dart:ui';

// Global navigator key for accessing context from anywhere
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

// This is the entry point for the background isolate
@pragma('vm:entry-point')
void notificationCallback(int id) async {
  // Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize timezone
  tz.initializeTimeZones();

  // Get the notification service
  final notificationService = NotificationService();

  // Show the notification
  await notificationService.showScheduledNotification(id);
}

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();
  bool _useExactAlarms = true;
  bool _isInitialized = false;

  // Store scheduled notifications for reference
  final Map<int, Map<String, dynamic>> _scheduledNotifications = {};

  Future<void> initialize() async {
    if (_isInitialized) return;

    // Initialize timezone
    tz.initializeTimeZones();

    // Initialize notification settings
    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );

    // Create notification channels for Android
    if (Platform.isAndroid) {
      await _createNotificationChannels();
    }

    // Request permissions
    await _requestPermissions();

    // Check for exact alarm permission on Android 12+
    if (Platform.isAndroid) {
      await _checkExactAlarmPermission();
    }

    // Initialize Android Alarm Manager
    try {
      await AndroidAlarmManager.initialize();
      print('Android Alarm Manager initialized');
    } catch (e) {
      print('Error initializing Android Alarm Manager: $e');
      _useExactAlarms = false;
    }

    _isInitialized = true;
  }

  Future<void> _createNotificationChannels() async {
    // Create a high importance channel for reminders
    const AndroidNotificationChannel reminderChannel =
        AndroidNotificationChannel(
      'reminder_channel',
      'Reminders',
      description: 'Notifications for health reminders',
      importance: Importance.high,
      enableVibration: true,
      playSound: true,
    );

    // Create a test channel
    const AndroidNotificationChannel testChannel = AndroidNotificationChannel(
      'test_channel',
      'Test',
      description: 'Test notifications',
      importance: Importance.low,
      enableVibration: false,
      playSound: false,
    );

    // Create the channels
    final AndroidFlutterLocalNotificationsPlugin? androidPlugin =
        _notifications.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    if (androidPlugin != null) {
      await androidPlugin.createNotificationChannel(reminderChannel);
      await androidPlugin.createNotificationChannel(testChannel);
      print('Notification channels created');
    }
  }

  Future<void> _requestPermissions() async {
    // Request iOS permissions
    await _notifications
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );

    // Request Android permissions
    if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidPlugin =
          _notifications.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();

      if (androidPlugin != null) {
        // For Android 13+ (API level 33+), we need to request notification permission
        if (Platform.isAndroid) {
          final bool? granted =
              await androidPlugin.requestNotificationsPermission();
          print('Android notification permission granted: $granted');
        }
      }
    }
  }

  Future<void> _checkExactAlarmPermission() async {
    try {
      // Check if we're on Android 12 or higher
      final androidInfo = _notifications.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();

      if (androidInfo != null) {
        // For Android 12+, we need to check if we can schedule exact alarms
        // This is a workaround since the API doesn't directly expose this
        _useExactAlarms = true;

        // We'll try to schedule a test notification and catch any exceptions
        try {
          await _notifications.zonedSchedule(
            999999, // Test ID
            'Test',
            'Test notification',
            tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
            const NotificationDetails(
              android: AndroidNotificationDetails(
                'test_channel',
                'Test',
                channelDescription: 'Test notifications',
                importance: Importance.low,
                priority: Priority.low,
              ),
            ),
            androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
          );
          // If we get here, exact alarms are allowed
          _useExactAlarms = true;
          print('Exact alarms are allowed');
          // Cancel the test notification
          await _notifications.cancel(999999);
        } catch (e) {
          // If we get an exception about exact alarms not being permitted
          if (e.toString().contains('exact_alarms_not_permitted')) {
            _useExactAlarms = false;
            print('Exact alarms are not permitted: $e');
          } else {
            print('Error testing exact alarms: $e');
          }
        }
      }
    } catch (e) {
      print('Error checking exact alarm permission: $e');
      _useExactAlarms = false;
    }
  }

  void _onNotificationTapped(NotificationResponse response) {
    // Handle notification tap
    print('Notification tapped: ${response.payload}');
  }

  Future<void> scheduleReminderNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
  }) async {
    // Make sure the service is initialized
    if (!_isInitialized) {
      await initialize();
    }

    // Cancel any existing notification with the same ID
    await cancelNotification(id);

    // Store the notification details for later use
    _scheduledNotifications[id] = {
      'title': title,
      'body': body,
    };

    // Calculate the delay in milliseconds
    final now = DateTime.now();
    final difference = scheduledDate.difference(now);
    final delayInMillis = difference.inMilliseconds;

    // If the scheduled time is in the past, don't schedule
    if (delayInMillis <= 0) {
      print('Scheduled time is in the past, not scheduling notification');
      return;
    }

    // For immediate testing, also show a notification right away
    if (delayInMillis < 60000) {
      // Less than 1 minute
      await _notifications.show(
        id + 1000000, // Different ID to avoid conflict
        'Immediate: $title',
        body,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'reminder_channel',
            'Reminders',
            channelDescription: 'Notifications for health reminders',
            importance: Importance.high,
            priority: Priority.high,
            icon: '@mipmap/ic_launcher',
          ),
          iOS: DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
      );
      print('Immediate notification shown');
    }

    // Schedule the notification using AndroidAlarmManager for Android
    if (Platform.isAndroid) {
      try {
        // Schedule the alarm
        final bool scheduled = await AndroidAlarmManager.periodic(
          const Duration(days: 1),
          id,
          notificationCallback,
          exact: _useExactAlarms,
          wakeup: true,
          rescheduleOnReboot: true,
          startAt: scheduledDate,
        );

        if (scheduled) {
          print('Alarm scheduled successfully for $scheduledDate');
        } else {
          print('Failed to schedule alarm');
        }
      } catch (e) {
        print('Error scheduling alarm: $e');

        // Fallback to zonedSchedule if AndroidAlarmManager fails
        await _scheduleWithZonedSchedule(id, title, body, scheduledDate);
      }
    } else {
      // For iOS, use zonedSchedule
      await _scheduleWithZonedSchedule(id, title, body, scheduledDate);
    }
  }

  Future<void> _scheduleWithZonedSchedule(
      int id, String title, String body, DateTime scheduledDate) async {
    try {
      await _notifications.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.from(scheduledDate, tz.local),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'reminder_channel',
            'Reminders',
            channelDescription: 'Notifications for health reminders',
            importance: Importance.high,
            priority: Priority.high,
            icon: '@mipmap/ic_launcher',
            enableVibration: true,
            playSound: true,
          ),
          iOS: DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        androidScheduleMode: _useExactAlarms
            ? AndroidScheduleMode.exactAllowWhileIdle
            : AndroidScheduleMode.inexactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.time,
      );
      print('Notification scheduled with zonedSchedule for $scheduledDate');
    } catch (e) {
      print('Error scheduling with zonedSchedule: $e');
      // If exact alarm fails, try with inexact alarm
      if (_useExactAlarms) {
        _useExactAlarms = false;
        await _scheduleWithZonedSchedule(id, title, body, scheduledDate);
      }
    }
  }

  // This method is called by the background isolate
  Future<void> showScheduledNotification(int id) async {
    // Make sure the service is initialized
    if (!_isInitialized) {
      await initialize();
    }

    // Get the notification details
    final notificationDetails = _scheduledNotifications[id];
    if (notificationDetails == null) {
      print('No notification details found for ID: $id');
      return;
    }

    // Show the notification
    await _notifications.show(
      id,
      notificationDetails['title'],
      notificationDetails['body'],
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'reminder_channel',
          'Reminders',
          channelDescription: 'Notifications for health reminders',
          importance: Importance.high,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
          enableVibration: true,
          playSound: true,
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
    );

    print('Scheduled notification shown for ID: $id');
  }

  Future<void> cancelNotification(int id) async {
    // Cancel the notification
    await _notifications.cancel(id);

    // Cancel the alarm if it exists
    if (Platform.isAndroid) {
      try {
        await AndroidAlarmManager.cancel(id);
        print('Alarm cancelled for ID: $id');
      } catch (e) {
        print('Error cancelling alarm: $e');
      }
    }

    // Remove from scheduled notifications
    _scheduledNotifications.remove(id);
  }

  // Method to show an immediate notification for testing
  Future<void> showTestNotification() async {
    // Make sure the service is initialized
    if (!_isInitialized) {
      await initialize();
    }

    await _notifications.show(
      888888,
      'Test Notification',
      'This is a test notification',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'reminder_channel',
          'Reminders',
          channelDescription: 'Notifications for health reminders',
          importance: Importance.high,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
          enableVibration: true,
          playSound: true,
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
    );
    print('Test notification shown');
  }
}
