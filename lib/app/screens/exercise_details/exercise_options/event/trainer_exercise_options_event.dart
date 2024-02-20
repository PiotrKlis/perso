import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:perso/app/screens/exercise_details/exercise_options/model/exercise_options_data.dart';

part 'trainer_exercise_options_event.freezed.dart';

@freezed
class TrainerExerciseOptionsEvent with _$TrainerExerciseOptionsEvent {
  const factory TrainerExerciseOptionsEvent.editExerciseOptions({
    required String clientId,
    required String date,
    required String exerciseInTrainingId,
    required ExerciseOptionsData exerciseOptionsData,
  }) = EditExerciseOptions;
}
