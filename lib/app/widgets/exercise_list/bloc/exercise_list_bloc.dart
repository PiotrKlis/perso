import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perso/app/widgets/exercise_list/event/exercise_list_event.dart';
import 'package:perso/app/widgets/exercise_list/state/exercise_list_state.dart';
import 'package:perso/core/dependency_injection/get_it.dart';
import 'package:perso/core/models/user_session_model.dart';
import 'package:perso/data/exercises/exercises_service/firestore_exercise_service.dart';
import 'package:perso/data/exercises/exercises_source/firestore_exercise_provider.dart';

class ExerciseListBloc extends Bloc<ExerciseListEvent, ExerciseListState> {
  ExerciseListBloc() : super(const ExerciseListState.init()) {
    final trainerId = _userSessionModel.user?.uid ?? '';

    on<GetAllExercises>((event, emitter) async {
      try {
        final exercises = await _exercisesProvider.getAllExercises();
        emitter(ExerciseListState.exercises(exercises));
      } catch (error) {
        emitter(ExerciseListState.error(error.toString()));
      }
    });

    on<GetExercises>((event, emitter) async {
      try {
        final exercisesStream = _exercisesProvider.getExercisesForTrainer(
          event.clientId,
          event.trainerId,
          event.date,
        );
        //TODO: Add sorting by index, take care of the same number. Change default index on firestore.
        await for (final exercises in exercisesStream) {
          exercises.sort((a, b) => a.index.compareTo(b.index));
          emitter(ExerciseListState.exercises(exercises));
        }
      } catch (error) {
        emitter(ExerciseListState.error(error.toString()));
      }
    });

    on<EditExercise>((event, emitter) async {
      try {
        await _exercisesService.editExercise(
          event.clientId,
          trainerId,
          event.exerciseId,
          event.date,
        );
        if (kDebugMode) {
          print('Exercise edited successfully');
        }
      } catch (error) {
        emitter(ExerciseListState.error(error.toString()));
      }
    });

    on<AddExercise>((event, emitter) async {
      try {
        await _exercisesService.addExercise(
          event.clientId,
          trainerId,
          event.date,
          event.exerciseEntity,
        );
      } catch (error) {
        emitter(ExerciseListState.error(error.toString()));
      }
    });

    on<RemoveExercise>((event, emitter) async {
      try {
        await _exercisesService.removeExercise(
          event.clientId,
          trainerId,
          event.date,
          event.exerciseId,
        );
        if (kDebugMode) {
          print('Exercise removed successfully');
        }
      } catch (error) {
        emitter(ExerciseListState.error(error.toString()));
      }
    });
  }

  final _userSessionModel = getIt.get<UserSessionModel>();
  final _exercisesProvider = getIt.get<FirestoreExerciseProvider>();
  final _exercisesService = getIt.get<FirestoreExerciseService>();
}
