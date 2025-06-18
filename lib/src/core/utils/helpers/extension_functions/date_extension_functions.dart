import 'package:intl/intl.dart';

extension ExtensionsOnNullableInt on int? {
  String? fromTimestampToDate() {
    if (this != null) {
      final DateTime date = DateTime.fromMillisecondsSinceEpoch(this! * 1000);
      return DateFormat('dd-MM-yyyy').format(date);
    }
    return null;
  }

  String? fromTimestampToTime() {
    if (this != null) {
      final DateTime date = DateTime.fromMillisecondsSinceEpoch(this! * 1000);
      return DateFormat.Hms().format(date);
    }
    return null;
  }
}
