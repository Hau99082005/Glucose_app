import 'package:flutter/cupertino.dart';
import 'package:flutter_app/src/core/providers/reminder_provider.dart';
import 'package:flutter_app/src/core/services/notification_service.dart';
import 'package:flutter_app/src/core/utils/values/styles.dart';
import 'package:provider/provider.dart';

class ReminderForm extends StatefulWidget {
  final String? initialRecordType;
  final DateTime? initialDay;
  final DateTime? initialTime;
  final int? reminderId;

  const ReminderForm({
    super.key,
    this.initialRecordType,
    this.initialDay,
    this.initialTime,
    this.reminderId,
  });

  @override
  State<ReminderForm> createState() => _ReminderFormState();
}

class _ReminderFormState extends State<ReminderForm> {
  final List<String> _recordTypes = [
    'Glucose',
    'Weight',
    'Blood Pressure',
    'Insulin',
    'Medication',
    'Carbs',
    'Temperature',
    'A1C',
    'Exercise',
    'Oxygen',
    'Ketones',
    'Note',
  ];

  final List<String> _days = [
    'Everyday',
    'Today',
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
  ];

  late String selectedRecordType;
  late String selectedDay;
  late DateTime selectedTime;
  final _notificationService = NotificationService();

  @override
  void initState() {
    super.initState();
    selectedRecordType = widget.initialRecordType ?? _recordTypes.first;
    selectedDay = widget.initialDay != null
        ? _getDayName(widget.initialDay!)
        : _days.first;
    selectedTime = widget.initialTime ?? DateTime.now();
  }

  String _getDayName(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final compareDate = DateTime(date.year, date.month, date.day);

    if (compareDate.difference(today).inDays.abs() <= 0) {
      return 'Today';
    } else {
      switch (date.weekday) {
        case 1:
          return 'Monday';
        case 2:
          return 'Tuesday';
        case 3:
          return 'Wednesday';
        case 4:
          return 'Thursday';
        case 5:
          return 'Friday';
        case 6:
          return 'Saturday';
        case 7:
          return 'Sunday';
        default:
          return 'Today';
      }
    }
  }

  DateTime _getDateTimeFromDay(String day) {
    final now = DateTime.now();

    if (day == 'Today') {
      return now;
    } else if (day == 'Everyday') {
      return now;
    } else {
      // Find the next occurrence of the selected day
      final today = now.weekday;
      int targetDay;

      switch (day) {
        case 'Monday':
          targetDay = 1;
          break;
        case 'Tuesday':
          targetDay = 2;
          break;
        case 'Wednesday':
          targetDay = 3;
          break;
        case 'Thursday':
          targetDay = 4;
          break;
        case 'Friday':
          targetDay = 5;
          break;
        case 'Saturday':
          targetDay = 6;
          break;
        case 'Sunday':
          targetDay = 7;
          break;
        default:
          targetDay = today;
      }

      int daysUntilTarget = targetDay - today;
      if (daysUntilTarget <= 0) {
        daysUntilTarget += 7; // Move to next week
      }

      return now.add(Duration(days: daysUntilTarget));
    }
  }

  Future<void> _scheduleNotification(
      int reminderId, String recordType, DateTime day, DateTime time) async {
    // Create a notification time by combining the day and time
    final notificationTime = DateTime(
      day.year,
      day.month,
      day.day,
      time.hour,
      time.minute,
    );

    // Schedule the notification
    await _notificationService.scheduleReminderNotification(
      id: reminderId,
      title: 'Health Reminder',
      body: 'Time to record your $recordType',
      scheduledDate: notificationTime,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      color: CupertinoColors.systemBackground,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            decoration: BoxDecoration(
              color: CupertinoColors.systemBackground,
              border: Border(
                bottom: BorderSide(
                  color: CupertinoColors.systemGrey.withOpacity(0.2),
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: Text(
                    'Cancel',
                    style: poppinsRegular.copyWith(
                        color: CupertinoColors.destructiveRed),
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                Text(
                  widget.reminderId == null
                      ? 'Create Reminder'
                      : 'Edit Reminder',
                  style: poppinsRegular.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: Text(
                    'Save',
                    style: poppinsRegular.copyWith(
                        color: CupertinoColors.activeBlue),
                  ),
                  onPressed: () async {
                    final provider = context.read<ReminderProvider>();
                    final dayDateTime = _getDateTimeFromDay(selectedDay);

                    if (widget.reminderId == null) {
                      // Create a new reminder
                      provider.addReminder(
                          selectedRecordType, dayDateTime, selectedTime);
                      // Get the latest reminder (which should be the one we just added)
                      final reminders = provider.reminders;
                      if (reminders.isNotEmpty) {
                        final latestReminder = reminders.first;
                        await _scheduleNotification(latestReminder.id,
                            selectedRecordType, dayDateTime, selectedTime);
                      }
                    } else {
                      // Update existing reminder
                      provider.updateReminder(
                        widget.reminderId!,
                        selectedRecordType,
                        dayDateTime,
                        selectedTime,
                      );
                      // Update notification for the existing reminder
                      await _scheduleNotification(widget.reminderId!,
                          selectedRecordType, dayDateTime, selectedTime);
                    }
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CupertinoFormSection(
                    children: [
                      CupertinoFormRow(
                        prefix: const Text('Type'),
                        child: CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            showCupertinoModalPopup(
                              context: context,
                              builder: (context) => Container(
                                height: 200,
                                color: CupertinoColors.systemBackground,
                                child: Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      decoration: BoxDecoration(
                                        color: CupertinoColors.systemBackground,
                                        border: Border(
                                          bottom: BorderSide(
                                            color: CupertinoColors.systemGrey
                                                .withOpacity(0.2),
                                          ),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CupertinoButton(
                                            padding: EdgeInsets.zero,
                                            child: const Text('Cancel'),
                                            onPressed: () =>
                                                Navigator.pop(context),
                                          ),
                                          Text(
                                            'Select Type',
                                            style: poppinsRegular.copyWith(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          CupertinoButton(
                                            padding: EdgeInsets.zero,
                                            child: const Text('Done'),
                                            onPressed: () =>
                                                Navigator.pop(context),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: CupertinoPicker(
                                        itemExtent: 32,
                                        onSelectedItemChanged: (index) {
                                          setState(() {
                                            selectedRecordType =
                                                _recordTypes[index];
                                          });
                                        },
                                        children: _recordTypes.map((type) {
                                          return Text(type);
                                        }).toList(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          child: Text(
                            selectedRecordType,
                            style: poppinsRegular,
                          ),
                        ),
                      ),
                      CupertinoFormRow(
                        prefix: const Text('Day'),
                        child: CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            showCupertinoModalPopup(
                              context: context,
                              builder: (context) => Container(
                                height: 200,
                                color: CupertinoColors.systemBackground,
                                child: Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      decoration: BoxDecoration(
                                        color: CupertinoColors.systemBackground,
                                        border: Border(
                                          bottom: BorderSide(
                                            color: CupertinoColors.systemGrey
                                                .withOpacity(0.2),
                                          ),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CupertinoButton(
                                            padding: EdgeInsets.zero,
                                            child: const Text('Cancel'),
                                            onPressed: () =>
                                                Navigator.pop(context),
                                          ),
                                          Text(
                                            'Select Day',
                                            style: poppinsRegular.copyWith(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          CupertinoButton(
                                            padding: EdgeInsets.zero,
                                            child: const Text('Done'),
                                            onPressed: () =>
                                                Navigator.pop(context),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: CupertinoPicker(
                                        itemExtent: 32,
                                        onSelectedItemChanged: (index) {
                                          setState(() {
                                            selectedDay = _days[index];
                                          });
                                        },
                                        children: _days.map((day) {
                                          return Text(day);
                                        }).toList(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          child: Text(
                            selectedDay,
                            style: poppinsRegular,
                          ),
                        ),
                      ),
                      CupertinoFormRow(
                        prefix: const Text('Time'),
                        child: CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            showCupertinoModalPopup(
                              context: context,
                              builder: (context) => Container(
                                height: 300,
                                color: CupertinoColors.systemBackground,
                                child: Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      decoration: BoxDecoration(
                                        color: CupertinoColors.systemBackground,
                                        border: Border(
                                          bottom: BorderSide(
                                            color: CupertinoColors.systemGrey
                                                .withOpacity(0.2),
                                          ),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CupertinoButton(
                                            padding: EdgeInsets.zero,
                                            child: const Text('Cancel'),
                                            onPressed: () =>
                                                Navigator.pop(context),
                                          ),
                                          Text(
                                            'Select Time',
                                            style: poppinsRegular.copyWith(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          CupertinoButton(
                                            padding: EdgeInsets.zero,
                                            child: const Text('Done'),
                                            onPressed: () =>
                                                Navigator.pop(context),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: CupertinoDatePicker(
                                        mode: CupertinoDatePickerMode.time,
                                        initialDateTime: selectedTime,
                                        onDateTimeChanged: (time) {
                                          setState(() {
                                            selectedTime = time;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          child: Text(
                            _formatTime(selectedTime),
                            style: poppinsRegular,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}
