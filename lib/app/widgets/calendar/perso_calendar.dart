import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perso/app/utils/extension/date_time_extensions.dart';
import 'package:perso/app/widgets/calendar/bloc/calendar_bloc.dart';
import 'package:perso/app/widgets/calendar/event/calendar_event.dart';
import 'package:perso/app/widgets/calendar/state/calendar_state.dart';
import 'package:table_calendar/table_calendar.dart';

class PersoCalendar extends StatefulWidget {
  const PersoCalendar({this.clientId, super.key, this.trainerId});

  final String? clientId;
  final String? trainerId;

  @override
  State<PersoCalendar> createState() => _PersoCalendarState();
}

class _PersoCalendarState extends State<PersoCalendar> {
  final _calendarFormat = CalendarFormat.week;
  DateTime _selectedDate = DateTime.now();
  Map<DateTime, bool> _markers = {};

  @override
  void initState() {
    super.initState();
    context.read<CalendarBloc>()
      ..add(
        CalendarEvent.updateSelectedDate(_selectedDate),
      )
      ..add(
        CalendarEvent.getMarkersForDates(
          _selectedDate.getMondayInTheWeek,
          _selectedDate.getSundayInTheWeek,
          widget.clientId,
          widget.trainerId,
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CalendarBloc, CalendarState>(
      listener: (context, state) {
        state.whenOrNull(
          markersData: (markers) {
            setState(() {
              _markers = markers;
            });
          },
        );
      },
      child: TableCalendar(
        headerStyle: const HeaderStyle(formatButtonVisible: false),
        calendarBuilders: CalendarBuilders(
          markerBuilder: (context, day, events) {
            final formattedDay = day.yearMonthDayHourMinuteSecondsMillisecondsFormat;
            if (_markers.containsKey(formattedDay) && _markers[formattedDay]!) {
              return Container(
                width: 4,
                height: 4,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,
                ),
              );
            }
            return null;
          },
        ),
        firstDay: DateTime.utc(2023, 11),
        lastDay: DateTime.utc(2028, 12, 31),
        focusedDay: _selectedDate,
        calendarFormat: _calendarFormat,
        startingDayOfWeek: StartingDayOfWeek.monday,
        selectedDayPredicate: (day) => isSameDay(_selectedDate, day),
        onDaySelected: (selectedDate, focusedDay) {
          if (_selectedDate != selectedDate) {
            context.read<CalendarBloc>().add(
                  CalendarEvent.updateSelectedDate(selectedDate),
                );
            setState(() {
              _selectedDate = selectedDate;
            });
          }
        },
        onPageChanged: (focusedDay) {
          context.read<CalendarBloc>().add(
                CalendarEvent.getMarkersForDates(
                  focusedDay.getMondayInTheWeek,
                  focusedDay.getSundayInTheWeek,
                  widget.clientId,
                  widget.trainerId,
                ),
              );
          context.read<CalendarBloc>().add(
                CalendarEvent.updateSelectedDate(focusedDay),
              );
          setState(() {
            _selectedDate = focusedDay;
          });
        },
      ),
    );
  }
}

// List<bool> getEventMarkerForDate(DateTime date, CalendarState state) {
//   return state.when(eventMarkersData: (events) {
//     return shouldShowMarker(events, date);
//   }, loadEventMarkers: (events) {
//     context.read<CalendarBloc>().add(CalendarEvent.getEventMarker(
//         selectedDate: _selectedDate,
//         clientId: widget.clientId,
//         dateTime: date));
//     return shouldShowMarker(events, date);
//   }, error: (String error) {
//     return [];
//   });
// }

// List<bool> shouldShowMarker(Map<DateTime, bool> events, DateTime day) {
//   var isEvent = events[day] ?? false;
//   return isEvent ? [isEvent] : [];
// }
