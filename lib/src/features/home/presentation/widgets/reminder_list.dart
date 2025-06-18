import 'package:flutter/cupertino.dart';
import 'package:flutter_app/src/core/providers/reminder_provider.dart';
import 'package:flutter_app/src/core/services/notification_service.dart';
import 'package:flutter_app/src/core/utils/values/colors.dart';
import 'package:flutter_app/src/core/utils/values/styles.dart';
import 'package:flutter_app/src/features/home/presentation/widgets/reminder_form.dart';
import 'package:provider/provider.dart';

class ReminderList extends StatelessWidget {
  const ReminderList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ReminderProvider>(
      builder: (context, provider, child) {
        final reminders = provider.reminders;
        return Column(
          children: [
            CupertinoButton(
              padding: const EdgeInsets.only(top: 16),
              color: CupertinoColors.systemGrey6,
              borderRadius: BorderRadius.circular(8),
              child: Text(
                'Remind me in 1 hour',
                style: poppinsRegular.copyWith(fontSize: 14, color: primary1),
              ),
              onPressed: () => _addQuickReminder(context, provider, 1),
            ),
            CupertinoButton(
              padding: const EdgeInsets.only(top: 16),
              color: CupertinoColors.systemGrey6,
              borderRadius: BorderRadius.circular(8),
              child: Text(
                'Remind me in 2 hours',
                style: poppinsRegular.copyWith(fontSize: 14, color: primary1),
              ),
              onPressed: () => _addQuickReminder(context, provider, 2),
            ),
            if (reminders.isEmpty)
              Expanded(
                  child: Container(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      CupertinoIcons.bell_slash,
                      size: 48,
                      color: CupertinoColors.systemGrey,
                    ),
                    const SizedBox(height: 16),
                    Text('No reminders yet',
                        style: poppinsRegular.copyWith(color: grey)),
                    const SizedBox(height: 8),
                    Text('Tap + to create a reminder',
                        style: poppinsRegular.copyWith(color: grey)),
                  ],
                ),
              )),
            if (reminders.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  itemCount: reminders.length + 1,
                  itemBuilder: (context, index) {
                    if (index == reminders.length) {
                      return Container(
                        margin: const EdgeInsets.only(top: 8),
                        alignment: Alignment.center,
                        child: Text(
                          'Swipe to delete',
                          style: poppinsRegular.copyWith(
                              fontSize: 12, color: grey),
                        ),
                      );
                    }
                    final reminder = reminders[index];
                    return Dismissible(
                      key: Key('reminder_${reminder.id}'),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        color: CupertinoColors.destructiveRed,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 16),
                        child: const Icon(
                          CupertinoIcons.delete,
                          color: CupertinoColors.white,
                        ),
                      ),
                      onDismissed: (direction) {
                        provider.deleteReminder(reminder.id);
                        NotificationService().cancelNotification(reminder.id);
                      },
                      child: Container(
                        color: CupertinoColors.white,
                        child: CupertinoListTile(
                          title: Text(
                            reminder.recordType,
                            style: poppinsRegular.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(
                            '${_formatDate(reminder.day)} at ${_formatTime(reminder.time)}',
                          ),
                          onTap: () =>
                              _showEditReminderModal(context, reminder),
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        );
      },
    );
  }

  void _addQuickReminder(
      BuildContext context, ReminderProvider provider, int hours) async {
    final now = DateTime.now();
    final reminderTime = now.add(Duration(hours: hours));

    provider.addReminder('Glucose', now, reminderTime);

    final reminders = provider.reminders;
    if (reminders.isNotEmpty) {
      final latestReminder = reminders.first;

      await NotificationService().scheduleReminderNotification(
        id: latestReminder.id,
        title: 'Health Reminder',
        body: 'Time to record your ${latestReminder.recordType}',
        scheduledDate: reminderTime,
      );
    }
  }

  void _showEditReminderModal(BuildContext context, Reminder reminder) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => ReminderForm(
        initialRecordType: reminder.recordType,
        initialDay: reminder.day,
        initialTime: reminder.time,
        reminderId: reminder.id,
      ),
    );
  }

  String _formatDate(DateTime date) {
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

  String _formatTime(DateTime time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}
