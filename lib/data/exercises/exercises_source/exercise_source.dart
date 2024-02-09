import 'package:perso/core/models/exercise_entity.dart';
import 'package:perso/core/models/exercise_in_training_entity.dart';
import 'package:perso/core/models/trainer_entity.dart';
import 'package:perso/core/models/trainer_identity.dart';

abstract class ExerciseSource {
  Future<List<ExerciseEntity>> getAllExercises();

  Future<List<ExerciseInTrainingEntity>> getExercisesForTrainer(
    String clientId,
    String trainerId,
    String date,
  );

  Future<List<ExerciseEntity>> getExercisesForClient({
    required String clientId,
    required String trainerId,
    required String date,
  });

  Future<int> getNumberOfExercises(
    String clientId,
    String trainerId,
    String date,
  );

  Future<Map<DateTime, bool>> getMarkersForDates(
    String clientId,
    String trainerId,
    DateTime startDate,
    DateTime endDate,
  );
}
