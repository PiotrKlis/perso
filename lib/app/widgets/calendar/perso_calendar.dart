import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perso/app/styleguide/value/app_dimens.dart';
import 'package:perso/app/widgets/calendar/bloc/calendar_bloc.dart';
import 'package:perso/app/widgets/calendar/event/calendar_event.dart';
import 'package:perso/app/widgets/calendar/state/calendar_state.dart';
import 'package:table_calendar/table_calendar.dart';

class PersoCalendar extends StatefulWidget {
  const PersoCalendar({required this.clientId, super.key});

  final String clientId;

  @override
  State<PersoCalendar> createState() => _PersoCalendarState();
}

class _PersoCalendarState extends State<PersoCalendar> {
  final _calendarFormat = CalendarFormat.week;
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    context.read<CalendarBloc>().add(
          CalendarEvent.updateSelectedDate(_selectedDate),
        );
  }

  @override
  Widget build(BuildContext context) {
    BlocBuilder<CalendarBloc, CalendarState>(
      builder: (context, state) {
        state.when(
          initial: () {},
          selectedDate: (selectedDate) {
            print(selectedDate);
          },
        );
        return Container();
      },
    );
    return TableCalendar(
      headerStyle: const HeaderStyle(formatButtonVisible: false),
      calendarBuilders: CalendarBuilders(
        markerBuilder: (context, day, events) {
          if (day.day.isEven) {
            return Padding(
              padding: const EdgeInsets.only(top: Dimens.lMargin),
              child: Container(
                width: 4,
                height: 4,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,
                ),
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
          setState(() {
            _selectedDate = selectedDate;
            context.read<CalendarBloc>().add(
                  CalendarEvent.updateSelectedDate(selectedDate),
                );
          });
        }
      },
      eventLoader: (date) {
        return List.empty();
        // return getEventMarkerForDate(date, state);
      },
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
