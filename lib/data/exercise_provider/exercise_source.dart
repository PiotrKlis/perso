import 'package:perso/core/models/exercise_entity.dart';

abstract class ExerciseSource {
  Future<List<ExerciseEntity>> getAllExercises();

  Future<void> editExercise(
    String clientId,
    String trainerId,
    String exerciseId,
    DateTime date,
  );

  Future<void> addExercise(
    String clientId,
    String trainerId,
    DateTime date,
    ExerciseEntity exerciseEntity,
  );

  Future<void> removeExercise(
    String clientId,
    String trainerId,
    DateTime date,
    String exerciseId,
  );
}
