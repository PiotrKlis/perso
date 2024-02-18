import 'package:perso/app/screens/plan_overview/trainer/widgets/exercise_options/model/exercise_options_data.dart';
import 'package:perso/core/models/exercise_entity.dart';
import 'package:perso/core/models/exercise_in_training_entity.dart';

abstract class ExerciseService {
  Future<void> editExerciseOptions({
    required String clientId,
    required String trainerId,
    required String exerciseId,
    required String date,
    required ExerciseOptionsData exerciseOptions,
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

  Future<String> sendToClient({
    required String clientId,
    required String trainerId,
    required String date,
  });

  Future<String> getSentDate({
    required String clientId,
    required String trainerId,
    required String date,
  });

  Future<void> sendSupersetData({
    required String trainerId,
    required String clientId,
    required String date,
    required Map<String, String> supersetData,
  });
}
