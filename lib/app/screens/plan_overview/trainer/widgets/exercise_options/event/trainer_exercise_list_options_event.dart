import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:perso/app/screens/plan_overview/exercise_options_data.dart';

part 'trainer_exercise_list_options_event.freezed.dart';

@freezed
class TrainerExerciseListOptionsEvent with _$TrainerExerciseListOptionsEvent {
  const factory TrainerExerciseListOptionsEvent.editExerciseType(
    String clientId,
    String date,
    String id,
    ExerciseOptionsData exerciseOptionsData,
  ) = EditExerciseType;

  const factory TrainerExerciseListOptionsEvent.editReps(
    String clientId,
    String date,
    String exerciseId,
    ExerciseOptionsData exerciseOptionsData,
  ) = EditReps;

  const factory TrainerExerciseListOptionsEvent.editTime(
    String clientId,
    String date,
    String exerciseId,
    ExerciseOptionsData exerciseOptionsData,
  ) = EditTime;
}
