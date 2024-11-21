import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime {
  String get yearMonthDayFormat => DateFormat('dd-MM-yyyy').format(this);

  String get yearMonthDayHourMinuteSecondsFormat =>
      DateFormat('dd-MM-yyyy HH:mm:ss').format(this);

  DateTime get getMondayInTheWeek => subtract(
        Duration(days: weekday - 1),
      );

  DateTime get getSundayInTheWeek => add(
        Duration(days: DateTime.daysPerWeek - weekday),
      );

  DateTime get yearMonthDayHourMinuteSecondsMillisecondsFormat =>
      DateTime.parse(DateFormat('dd-MM-yyyy HH:mm:ss.SSS').format(this));
}
