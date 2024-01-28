import 'package:perso/core/models/exercise_entity.dart';
import 'package:perso/core/models/exercise_in_training_entity.dart';

abstract class ExerciseService {
  Future<void> editExerciseType({
    required String clientId,
    required String trainerId,
    required String exerciseId,
    required String date,
    required String exerciseType,
  });

  Future<void> add({
    required String clientId,
    required String trainerId,
    required String date,
    required ExerciseEntity exerciseEntity,
  });

  Future<void> remove({
    required String clientId,
    required String trainerId,
    required String date,
    required ExerciseInTrainingEntity exerciseInTrainingEntity,
    required List<ExerciseInTrainingEntity> exerciseInTrainingEntityList,
  });

  Future<void> reorder({
    required String clientId,
    required String trainerId,
    required String date,
    required List<ExerciseInTrainingEntity> exercises,
  });

  Future<void> editReps({
    required String clientId,
    required String trainerId,
    required String date,
    required String exerciseId,
    required int reps,
    required int sets,
  });

  Future<void> editTime({
    required String clientId,
    required String trainerId,
    required String date,
    required String exerciseId,
    required String time,
  });
}
