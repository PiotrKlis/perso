import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:perso/app/screens/exercise_details/exercise_options/model/exercise_options_data.dart';

part 'trainer_exercise_list_options_state.freezed.dart';

@freezed
class TrainerExerciseListOptionsState with _$TrainerExerciseListOptionsState {
  const factory TrainerExerciseListOptionsState.exerciseOptionsDataUpdate(
    ExerciseOptionsData optionsData,
  ) = ExerciseOptionsDataUpdate;

  const factory TrainerExerciseListOptionsState.initial() = Initial;
}
