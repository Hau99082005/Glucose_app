  import 'package:intl/intl.dart';

String formatDayHeader(DateTime date,{bool hasTime = false, bool hasNow = false}) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final compareDate = hasTime ? DateTime(date.year, date.month, date.day, date.hour, date.minute) : DateTime(date.year, date.month, date.day);
    
    if ((hasTime && compareDate.difference(now).inMinutes.abs() <= 2) || (!hasTime && compareDate.difference(today).inDays.abs() <= 0)) {
      return hasNow ? 'Now' : 'Today';
    } else if (compareDate.difference(yesterday).inMinutes.abs() <= 2) {
      return 'Yesterday';
    } else {
       var outputFormat = hasTime ? DateFormat('EEE, dd MMM, HH:mm') : DateFormat('EEE, dd MMM');
       return outputFormat.format(date);
    }
  }