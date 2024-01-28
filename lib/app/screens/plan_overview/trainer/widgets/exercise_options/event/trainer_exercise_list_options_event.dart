import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:perso/core/models/exercise_type.dart';

part 'trainer_exercise_list_options_event.freezed.dart';

@freezed
class TrainerExerciseListOptionsEvent with _$TrainerExerciseListOptionsEvent {
  const factory TrainerExerciseListOptionsEvent.getOptions(
    String clientId,
    String date,
    String exerciseId,
  ) = GetOptions;

  const factory TrainerExerciseListOptionsEvent.editExerciseType(
    String clientId,
    String date,
    String id,
    ExerciseType exerciseType,
  ) = EditExerciseType;

  const factory TrainerExerciseListOptionsEvent.editReps(
    String clientId,
    String date,
    String exerciseId,
    String reps,
    String sets,
  ) = EditReps;

  const factory TrainerExerciseListOptionsEvent.editTime(
    String clientId,
    String date,
    String exerciseId,
    String seconds,
    String minutes,
  ) = EditTime;
}
