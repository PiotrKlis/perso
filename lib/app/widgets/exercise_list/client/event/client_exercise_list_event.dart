import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:perso/core/models/exercise_entity.dart';
import 'package:perso/core/models/exercise_in_training_entity.dart';

part 'client_exercise_list_event.freezed.dart';

@freezed
class ClientExerciseListEvent with _$ClientExerciseListEvent {
  const factory ClientExerciseListEvent.getAllExercises() = GetAllExercises;

  const factory ClientExerciseListEvent.getExercises(
    String clientId,
    String trainerId,
    String date,
  ) = GetExercises;

  const factory ClientExerciseListEvent.editExercise(
    String clientId,
    String exerciseId,
    String date,
  ) = EditExercise;

  const factory ClientExerciseListEvent.addExercise(
    String clientId,
    String date,
    ExerciseEntity exerciseEntity,
  ) = AddExercise;

  const factory ClientExerciseListEvent.removeExercise(
    String clientId,
    String date,
    String exerciseId,
  ) = RemoveExercise;

  const factory ClientExerciseListEvent.reorder(
    String clientId,
    String date,
    List<ExerciseInTrainingEntity> exercises,
  ) = Reorder;

  const factory ClientExerciseListEvent.getNumberOfExercises(
    String clientId,
    String date,
  ) = GetNumberOfExercises;
}
