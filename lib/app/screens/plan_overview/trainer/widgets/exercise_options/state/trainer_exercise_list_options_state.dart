import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:perso/core/models/exercise_type.dart';

part 'trainer_exercise_list_options_state.freezed.dart';

@freezed
class TrainerExerciseListOptionsState with _$TrainerExerciseListOptionsState {
  const factory TrainerExerciseListOptionsState.exerciseOptions(
    ExerciseType exerciseType,
    String reps,
    String sets,
    String time,
  ) = ExerciseOptions;

  const factory TrainerExerciseListOptionsState.initial() = Initial;
}
