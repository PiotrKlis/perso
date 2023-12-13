import 'package:perso/core/models/exercise_entity.dart';

abstract class ExerciseService {
  Future<void> editExercise(
    String clientId,
    String trainerId,
    String exerciseId,
    String date,
  );

  Future<void> addExercise(
    String clientId,
    String trainerId,
    String date,
    ExerciseEntity exerciseEntity,
  );

  Future<void> removeExercise(
    String clientId,
    String trainerId,
    String date,
    String exerciseId,
  );
}
