import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:perso/core/models/exercise_in_training_entity.dart';

part 'client_exercise_list_state.freezed.dart';

@freezed
class ClientExerciseListState with _$ClientExerciseListState {
  const factory ClientExerciseListState.exercises(
    List<ExerciseInTrainingEntity> exercises,
  ) = Exercises;

  const factory ClientExerciseListState.error(String error) = Error;

  const factory ClientExerciseListState.loading() = Loading;
}
