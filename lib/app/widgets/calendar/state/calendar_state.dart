import 'package:freezed_annotation/freezed_annotation.dart';

part 'calendar_state.freezed.dart';

@freezed
class CalendarState with _$CalendarState {
  const factory CalendarState.initial() = Initial;

  const factory CalendarState.selectedDate(String selectedDate) = SelectedDate;

  const factory CalendarState.markersData(Map<DateTime, bool> selectedDate) =
      MarkersData;
}
