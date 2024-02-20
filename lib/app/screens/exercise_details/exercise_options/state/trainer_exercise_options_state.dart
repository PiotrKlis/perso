import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:perso/app/screens/exercise_details/exercise_options/model/exercise_options_data.dart';

part 'trainer_exercise_options_state.freezed.dart';

@freezed
class TrainerExerciseOptionsState with _$TrainerExerciseOptionsState {
  const factory TrainerExerciseOptionsState.exerciseOptionsDataUpdate(
    ExerciseOptionsData optionsData,
  ) = ExerciseOptionsDataUpdate;

  const factory TrainerExerciseOptionsState.initial() = Initial;
}
