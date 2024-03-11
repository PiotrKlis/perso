import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perso/app/screens/exercise_details/event/exercise_details_event.dart';
import 'package:perso/app/screens/exercise_details/state/exercise_details_state.dart';
import 'package:perso/core/dependency_injection/get_it.dart';
import 'package:perso/core/models/user_session_model.dart';
import 'package:perso/data/exercises/exercises_service/firestore_exercise_service.dart';
import 'package:perso/data/exercises/exercises_source/firestore_exercise_provider.dart';

class ExerciseDetailsBloc
    extends Bloc<ExerciseDetailsEvent, ExerciseDetailsState> {
  ExerciseDetailsBloc() : super(const ExerciseDetailsState.initial()) {
    final trainerId = _userSessionModel.user?.uid ?? '';

    on<GetNumberOfExercises>((event, emitter) async {
      try {
        final numberOfExercises = await _exerciseProvider.getNumberOfExercises(
          clientId: event.clientId,
          trainerId: trainerId,
          date: event.date,
        );
        _nextExerciseIndex = numberOfExercises;
      } catch (error) {
        //TODO: Add error handling
      }
    });

    on<SaveExercise>((event, emitter) async {
      try {
        final updatedExerciseEntity =
            event.exerciseInTrainingEntity.exerciseEntity.copyWith(
          index: _nextExerciseIndex,
        );
        final updatedExerciseInTrainingEntity =
            event.exerciseInTrainingEntity.copyWith(
          exerciseEntity: updatedExerciseEntity,
        );
        await _exercisesService.add(
          clientId: event.clientId,
          trainerId: trainerId,
          date: event.date,
          exerciseInTrainingEntity: updatedExerciseInTrainingEntity,
        );
        _nextExerciseIndex++;
      } catch (error) {
        //TODO: Add error handling
      }
    });

    on<DeleteExercise>((event, emitter) async {
      try {
        await _exercisesService.remove(
          clientId: event.clientId,
          trainerId: trainerId,
          date: event.date,
          exerciseInTrainingId: event.exerciseInTrainingId,
        );
        _nextExerciseIndex--;
      } catch (error) {
        //TODO: Add error handling
      }
    });
  }

  int _nextExerciseIndex = 0;
  final _userSessionModel = getIt.get<UserSessionModel>();
  final _exercisesService = getIt.get<FirestoreExerciseService>();
  final _exerciseProvider = getIt.get<FirestoreExerciseProvider>();
}
