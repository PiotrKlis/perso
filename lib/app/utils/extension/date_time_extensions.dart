import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime {
  String get yearMonthDayFormat => DateFormat('yyyy-MM-dd').format(this);

  String get yearMonthDayHourMinuteSecondsFormat =>
      DateFormat('yyyy-MM-dd HH:mm:ss').format(this);

  DateTime get getMondayInTheWeek => subtract(
        Duration(days: weekday - 1),
      );

  DateTime get getSundayInTheWeek => add(
        Duration(days: DateTime.daysPerWeek - weekday),
      );

  DateTime get yearMonthDayHourMinuteSecondsMillisecondsFormat =>
      DateTime.parse(DateFormat('yyyy-MM-dd HH:mm:ss.SSS').format(this));
}
