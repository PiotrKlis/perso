import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perso/app/widgets/exercise_list/event/exercise_list_event.dart';
import 'package:perso/app/widgets/exercise_list/state/exercise_list_state.dart';
import 'package:perso/core/dependency_injection/get_it.dart';
import 'package:perso/core/models/user_session_model.dart';
import 'package:perso/data/exercise_provider/firestore_exercise_provider.dart';
import 'package:perso/data/user_info/user_info_provider.dart';

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
        final exercises = await _exercisesProvider.getAllExercises();
        emitter(ExerciseListState.exercises(exercises));
      } catch (error) {
        emitter(ExerciseListState.error(error.toString()));
      }
    });

    on<EditExercise>((event, emitter) async {
      try {
        await _exercisesProvider.editExercise(
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
        await _exercisesProvider.addExercise(
          event.clientId,
          trainerId,
          event.date,
          event.exerciseEntity,
        );
        if (kDebugMode) {
          print('Exercise added successfully');
        }
      } catch (error) {
        emitter(ExerciseListState.error(error.toString()));
      }
    });

    on<RemoveExercise>((event, emitter) async {
      try {
        await _exercisesProvider.removeExercise(
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
}
