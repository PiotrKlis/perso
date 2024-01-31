import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:perso/app/screens/plan_overview/exercise_options_data.dart';

part 'trainer_exercise_list_options_event.freezed.dart';

@freezed
class TrainerExerciseListOptionsEvent with _$TrainerExerciseListOptionsEvent {
  const factory TrainerExerciseListOptionsEvent.editExerciseOptions({
    required String clientId,
    required String date,
    required String exerciseInTrainingId,
    required ExerciseOptionsData exerciseOptionsData,
  }) = EditExerciseOptions;
}
