import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:perso/core/models/exercise_entity.dart';

part 'exercise_list_event.freezed.dart';

@freezed
class ExerciseListEvent with _$ExerciseListEvent {
  const factory ExerciseListEvent.getAllExercises() = GetAllExercises;

  const factory ExerciseListEvent.getExercises(
    String clientId,
    String trainerId,
    String date,
  ) = GetExercises;

  const factory ExerciseListEvent.editExercise(
    String clientId,
    String exerciseId,
    String date,
  ) = EditExercise;

  const factory ExerciseListEvent.addExercise(
    String clientId,
    String date,
    ExerciseEntity exerciseEntity,
  ) = AddExercise;

  const factory ExerciseListEvent.removeExercise(
    String clientId,
    String date,
    String exerciseId,
  ) = RemoveExercise;

  const factory ExerciseListEvent.reorder(
    String clientId,
    String date,
    List<ExerciseEntity> exercises,
  ) = Reorder;

  const factory ExerciseListEvent.getNumberOfExercises(
    String clientId,
    String date,
  ) = GetNumberOfExercises;
}
