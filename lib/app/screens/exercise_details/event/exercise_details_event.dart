import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:perso/core/models/exercise_in_training_entity.dart';

part 'exercise_details_event.freezed.dart';

@freezed
class ExerciseDetailsEvent with _$ExerciseDetailsEvent {
  const factory ExerciseDetailsEvent.saveExercise({
    required String clientId,
    required String date,
    required ExerciseInTrainingEntity exerciseInTrainingEntity,
  }) = SaveExercise;

  const factory ExerciseDetailsEvent.deleteExercise({
    required String clientId,
    required String date,
    required String exerciseInTrainingId,
  }) = DeleteExercise;

  const factory ExerciseDetailsEvent.getNumberOfExercises({
    required String clientId,
    required String date,
  }) = GetNumberOfExercises;
}
