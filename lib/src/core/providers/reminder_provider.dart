import 'package:flutter/foundation.dart';
import '../database/database_helper.dart';

class Reminder {
  final int id;
  final String recordType;
  final DateTime day;
  final DateTime time;
  final bool isActive;

  Reminder({
    required this.id,
    required this.recordType,
    required this.day,
    required this.time,
    required this.isActive,
  });

  factory Reminder.fromMap(Map<String, dynamic> map) {
    return Reminder(
      id: map['id'] as int,
      recordType: map['record_type'] as String,
      day: DateTime.parse(map['day'] as String),
      time: DateTime.parse(map['time'] as String),
      isActive: map['is_active'] == 1,
    );
  }
}

class ReminderProvider extends ChangeNotifier {
  final DatabaseHelper _db = DatabaseHelper.instance;
  List<Reminder> _reminders = [];
  List<Reminder> get reminders => _reminders;

  ReminderProvider() {
    loadReminders();
  }

  Future<void> loadReminders() async {
    final db = await _db.database;
    final maps = await _db.getAllReminders();
    _reminders = maps.map((map) => Reminder.fromMap(map)).toList();
    notifyListeners();
  }

  Future<void> addReminder(String recordType, DateTime day, DateTime time) async {
    await _db.addReminder(recordType, day, time);
    await loadReminders();
  }

  Future<void> updateReminder(int id, String recordType, DateTime day, DateTime time) async {
    await _db.updateReminder(id, recordType, day, time, true);
    await loadReminders();
  }

  Future<void> deleteReminder(int id) async {
    await _db.deleteReminder(id);
    await loadReminders();
  }

  Future<void> toggleReminderActive(int id, bool isActive) async {
    await _db.toggleReminderActive(id, isActive);
    await loadReminders();
  }
} 