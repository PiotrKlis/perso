import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perso/app/utils/extension/date_time_extensions.dart';
import 'package:perso/app/widgets/calendar/event/calendar_event.dart';
import 'package:perso/app/widgets/calendar/state/calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  CalendarBloc() : super(const CalendarState.initial()) {
    on<UpdateSelectedDate>((event, emitter) async {
      emitter(
        CalendarState.selectedDate(
          event.selectedDate.yearMonthDayFormat,
        ),
      );
    });
  }
}
