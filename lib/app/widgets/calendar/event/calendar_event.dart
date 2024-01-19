import 'package:freezed_annotation/freezed_annotation.dart';

part 'calendar_event.freezed.dart';

@freezed
class CalendarEvent with _$CalendarEvent {
  const factory CalendarEvent.updateSelectedDate(DateTime selectedDate) =
      UpdateSelectedDate;

  const factory CalendarEvent.getMarkersForDates(
    DateTime startDate,
    DateTime endDate,
    String? clientId,
    String? trainerId,
  ) = GetMarkersForDates;

  const factory CalendarEvent.activateMarkerListener(
    DateTime selectedDate,
    String? clientId,
    String? trainerId,
  ) = ActivateMarkerListener;
}
