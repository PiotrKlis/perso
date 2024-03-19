import 'package:perso/core/models/exercise_entity.dart';
import 'package:perso/core/models/exercise_in_training_entity.dart';

abstract class ExerciseSource {
  Future<List<ExerciseEntity>> getAllExercises();

  Future<List<ExerciseInTrainingEntity>> getExercises({
    required String clientId,
    required String trainerId,
    required String date,
  });

  Future<int> getNumberOfExercises({
    required String clientId,
    required String trainerId,
    required String date,
  });

  Future<Map<DateTime, bool>> getMarkersForDates(
    String clientId,
    String trainerId,
    DateTime startDate,
    DateTime endDate,
  );
}
