import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:perso/core/models/exercise_in_training_entity.dart';

part 'trainer_exercise_list_state.freezed.dart';

@freezed
class TrainerExerciseListState with _$TrainerExerciseListState {
  const factory TrainerExerciseListState.exercises(
      List<ExerciseInTrainingEntity> exercises,) = Exercises;

  const factory TrainerExerciseListState.init() = Init;

  const factory TrainerExerciseListState.error(String error) = Error;
}
