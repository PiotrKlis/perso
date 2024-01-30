import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perso/app/screens/plan_overview/trainer/widgets/exercise_options/event/trainer_exercise_list_options_event.dart';
import 'package:perso/app/screens/plan_overview/trainer/widgets/exercise_options/state/trainer_exercise_list_options_state.dart';
import 'package:perso/app/utils/event_transformer.dart';
import 'package:perso/core/dependency_injection/get_it.dart';
import 'package:perso/core/models/user_session_model.dart';
import 'package:perso/data/exercises/exercises_service/firestore_exercise_service.dart';

class TrainerExerciseListOptionsBloc extends Bloc<
    TrainerExerciseListOptionsEvent, TrainerExerciseListOptionsState> {
  TrainerExerciseListOptionsBloc()
      : super(const TrainerExerciseListOptionsState.initial()) {
    final trainerId = _userSessionModel.user?.uid ?? '';

    on<EditReps>(
      (event, emitter) async {
        try {
          emitter(
            TrainerExerciseListOptionsState.exerciseOptionsDataUpdate(
              event.exerciseOptionsData,
            ),
          );
          await _exercisesService.editReps(
            clientId: event.clientId,
            trainerId: trainerId,
            exerciseId: event.exerciseId,
            date: event.date,
            reps: int.parse(event.exerciseOptionsData.reps),
            sets: int.parse(event.exerciseOptionsData.sets),
          );
        } catch (error) {
          print(error);
        }
      },
    );

    on<EditTime>(
      (event, emitter) async {
        try {
          emitter(
            TrainerExerciseListOptionsState.exerciseOptionsDataUpdate(
              event.exerciseOptionsData,
            ),
          );
          await _exercisesService.editTime(
            clientId: event.clientId,
            trainerId: trainerId,
            exerciseId: event.exerciseId,
            date: event.date,
            time: event.exerciseOptionsData.time,
          );
        } catch (error) {
          print(error);
        }
      },
    );

    on<EditExerciseType>((event, emitter) async {
      try {
        emitter(
          TrainerExerciseListOptionsState.exerciseOptionsDataUpdate(
            event.exerciseOptionsData,
          ),
        );
        await _exercisesService.editExerciseType(
          clientId: event.clientId,
          trainerId: trainerId,
          exerciseId: event.id,
          date: event.date,
          exerciseType: event.exerciseOptionsData.exerciseType.name,
        );
      } catch (error) {
        print(error);
      }
    });
  }

  final _userSessionModel = getIt.get<UserSessionModel>();
  final _exercisesService = getIt.get<FirestoreExerciseService>();
}
