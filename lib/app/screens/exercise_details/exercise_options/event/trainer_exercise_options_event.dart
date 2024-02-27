import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:perso/app/screens/exercise_details/exercise_options/model/exercise_options_data.dart';
import 'package:perso/core/models/exercise_in_training_entity.dart';

part 'trainer_exercise_options_event.freezed.dart';

@freezed
class TrainerExerciseOptionsEvent with _$TrainerExerciseOptionsEvent {
  const factory TrainerExerciseOptionsEvent.editExerciseOptions({
    required String clientId,
    required String date,
    required ExerciseInTrainingEntity exerciseInTrainingEntity,
  }) = EditExerciseOptions;

  const factory TrainerExerciseOptionsEvent.changeExerciseType(
      {required ExerciseOptionsData exerciseOptionsData}) = ChangeExerciseType;
}
