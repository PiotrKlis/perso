import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:perso/app/screens/exercise_details/exercise_options/model/exercise_options_data.dart';
import 'package:perso/core/models/exercise_type.dart';

part 'trainer_exercise_options_state.freezed.dart';

@freezed
class TrainerExerciseOptionsState with _$TrainerExerciseOptionsState {
  const factory TrainerExerciseOptionsState.exerciseOptionsDataUpdate(
    ExerciseOptionsData exerciseOptionsData,
  ) = ExerciseOptionsDataUpdate;

  const factory TrainerExerciseOptionsState.initial() = Initial;
}
