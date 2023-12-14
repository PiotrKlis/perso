import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime {
  String get yearMonthDayFormat => DateFormat('yyyy-MM-dd').format(this);
}
