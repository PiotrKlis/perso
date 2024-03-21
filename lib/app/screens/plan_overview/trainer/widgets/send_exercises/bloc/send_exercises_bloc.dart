import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perso/app/screens/plan_overview/trainer/widgets/send_exercises/event/send_exercises_event.dart';
import 'package:perso/app/screens/plan_overview/trainer/widgets/send_exercises/state/send_exercises_state.dart';
import 'package:perso/app/widgets/calendar/bloc/calendar_bloc.dart';
import 'package:perso/app/widgets/calendar/event/calendar_event.dart';
import 'package:perso/core/dependency_injection/get_it.dart';
import 'package:perso/core/models/user_session_model.dart';
import 'package:perso/data/exercises/exercises_service/firestore_exercise_service.dart';

class SendExerciseBloc extends Bloc<SendExercisesEvent, SendExercisesState> {
  SendExerciseBloc() : super(const SendExercisesState.initial()) {
    on<SendExercises>((event, emitter) async {
      try {
        emitter(const SendExercisesState.sendingInProgress());
        final sentDate = await _exerciseService.sendToClient(
          clientId: event.clientId,
          date: event.date,
          trainerId: _userSessionModel.user?.uid ?? '',
        );
        emitter(SendExercisesState.exerciseSentDate(sentDate));
        //TODO: reload markers
      } catch (error) {
        emitter(SendExercisesState.error(error.toString()));
      }
    });
    on<GetExercisesSentDate>((event, emitter) async {
      try {
        final sentDate = await _exerciseService.getSentDate(
          clientId: event.clientId,
          date: event.date,
          trainerId: _userSessionModel.user?.uid ?? '',
        );
        emitter(SendExercisesState.exerciseSentDate(sentDate));
      } catch (error) {
        emitter(SendExercisesState.error(error.toString()));
      }
    });
  }

  final _exerciseService = getIt.get<FirestoreExerciseService>();
  final _userSessionModel = getIt.get<UserSessionModel>();
}
