import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:perso/core/models/exercise_in_training_entity.dart';

part 'trainer_exercise_list_event.freezed.dart';

@freezed
class TrainerExerciseListEvent with _$TrainerExerciseListEvent {
  const factory TrainerExerciseListEvent.fetchExercises(
    String clientId,
    String date,
  ) = FetchExercises;

  const factory TrainerExerciseListEvent.reorder(
    String clientId,
    String date,
    List<ExerciseInTrainingEntity> exercises,
  ) = Reorder;
}
