import 'package:flutter/material.dart';
import 'package:perso/app/styleguide/value/app_dimens.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarWidget extends StatelessWidget {
  const CalendarWidget({required this.clientId, super.key});

  final String clientId;

  @override
  Widget build(BuildContext context) {
    return TableCalendarWidget(clientId: clientId);
  }
}

class TableCalendarWidget extends StatefulWidget {
  const TableCalendarWidget({required this.clientId, super.key});

  final String clientId;

  @override
  State<TableCalendarWidget> createState() => _TableCalendarState();
}

class _TableCalendarState extends State<TableCalendarWidget> {
  final _calendarFormat = CalendarFormat.week;
  var _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return TableCalendar<bool>(
      headerStyle: const HeaderStyle(formatButtonVisible: false),
      calendarBuilders: CalendarBuilders(
        markerBuilder: (context, day, events) {
          if (day.day.isEven) {
            return Padding(
              padding: const EdgeInsets.only(top: Dimens.bigMargin),
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
