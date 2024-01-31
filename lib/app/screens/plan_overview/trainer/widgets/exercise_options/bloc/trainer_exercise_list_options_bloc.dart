import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perso/app/screens/plan_overview/trainer/widgets/exercise_list/event/trainer_exercise_list_event.dart';
import 'package:perso/app/screens/plan_overview/trainer/widgets/exercise_options/event/trainer_exercise_list_options_event.dart';
import 'package:perso/app/screens/plan_overview/trainer/widgets/exercise_options/state/trainer_exercise_list_options_state.dart';
import 'package:perso/core/dependency_injection/get_it.dart';
import 'package:perso/core/models/user_session_model.dart';
import 'package:perso/data/exercises/exercises_service/firestore_exercise_service.dart';

class TrainerExerciseListOptionsBloc extends Bloc<
    TrainerExerciseListOptionsEvent, TrainerExerciseListOptionsState> {
  TrainerExerciseListOptionsBloc()
      : super(const TrainerExerciseListOptionsState.initial()) {
    final trainerId = _userSessionModel.user?.uid ?? '';

    on<EditExerciseOptions>((event, emitter) async {
      try {
        await _exercisesService.editExerciseOptions(
          clientId: event.clientId,
          trainerId: trainerId,
          exerciseId: event.exerciseInTrainingId,
          date: event.date,
          exerciseOptions: event.exerciseOptionsData,
        );
      } catch (error) {
        print(error);
      }
    });

  }

  final _userSessionModel = getIt.get<UserSessionModel>();
  final _exercisesService = getIt.get<FirestoreExerciseService>();
}
