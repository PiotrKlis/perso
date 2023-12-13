import 'package:perso/core/models/exercise_entity.dart';

abstract class ExerciseSource {
  Future<List<ExerciseEntity>> getAllExercises();

  Stream<List<ExerciseEntity>> getExercisesForTrainer(
      String clientId, String trainerId, String date);

  Future<List<ExerciseEntity>> getExercisesForClient(
      String clientId, String trainerId, String date);
}
