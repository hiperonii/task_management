import 'package:intl/intl.dart';

extension DatetimeExtension on DateTime {
  String format([String pattern = 'dd MMM yyyy']) {
    final DateFormat formatter = DateFormat(pattern);
    return formatter.format(this);
  }
}
