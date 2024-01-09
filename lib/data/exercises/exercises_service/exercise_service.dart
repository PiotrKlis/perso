import 'package:perso/core/models/exercise_entity.dart';
import 'package:perso/core/models/exercise_in_training_entity.dart';

abstract class ExerciseService {
  Future<void> edit(
    String clientId,
    String trainerId,
    String exerciseId,
    String date,
  );

  Future<void> add(
    String clientId,
    String trainerId,
    String date,
    ExerciseEntity exerciseEntity,
  );

  Future<void> remove(
    String clientId,
    String trainerId,
    String date,
    String exerciseId,
  );

  Future<void> reorder(
    String clientId,
    String trainerId,
    String date,
    List<ExerciseInTrainingEntity> exercises,
  );
}
