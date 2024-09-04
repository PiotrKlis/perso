import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perso/app/widgets/calendar/event/calendar_event.dart';
import 'package:perso/app/widgets/calendar/state/calendar_state.dart';
import 'package:perso/core/dependency_injection/get_it.dart';
import 'package:perso/core/extensions/date_time_extensions.dart';
import 'package:perso/core/models/user_session_model.dart';
import 'package:perso/data/exercises/exercises_source/firestore_exercise_provider.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  CalendarBloc() : super(const CalendarState.initial()) {
    on<UpdateSelectedDate>((event, emitter) async {
      emitter(
        CalendarState.selectedDate(
          event.selectedDate.yearMonthDayFormat,
        ),
      );
    });

    on<GetMarkersForDates>(
      (event, emitter) async {
        try {
          final markers = await _exercisesProvider.getMarkersForDates(
            event.clientId ?? _userSessionModel.user?.uid ?? '',
            event.trainerId ?? _userSessionModel.user?.uid ?? '',
            event.startDate,
            event.endDate,
          );
          emitter(CalendarState.markersData(markers));
        } catch (error) {
          if (kDebugMode) {
            print(error);
          }
        }
      },
      transformer: restartable(),
    );
  }

  final _userSessionModel = getIt.get<UserSessionModel>();
  final _exercisesProvider = getIt.get<FirestoreExerciseProvider>();
}
