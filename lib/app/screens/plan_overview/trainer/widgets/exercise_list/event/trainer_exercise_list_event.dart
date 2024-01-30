import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:perso/app/screens/plan_overview/trainer/widgets/exercise_list/perso_trainer_exercise_list.dart';
import 'package:perso/app/screens/plan_overview/trainer/widgets/exercise_options/perso_trainer_exercise_options.dart';
import 'package:perso/core/models/exercise_entity.dart';
import 'package:perso/core/models/exercise_in_training_entity.dart';

part 'trainer_exercise_list_event.freezed.dart';

@freezed
class TrainerExerciseListEvent with _$TrainerExerciseListEvent {
  const factory TrainerExerciseListEvent.getAllExercises() = GetAllExercises;

  const factory TrainerExerciseListEvent.emitExercise(
    List<ExerciseInTrainingEntity> exercises,
  ) = EmitExercise;

  const factory TrainerExerciseListEvent.fetchExercises(
    String clientId,
    String date,
  ) = FetchExercises;

  const factory TrainerExerciseListEvent.addExercise(
    String clientId,
    String date,
    ExerciseEntity exerciseEntity,
  ) = AddExercise;

  const factory TrainerExerciseListEvent.removeExercise(
          String clientId,
          String date,
          ExerciseInTrainingEntity exerciseInTrainingEntity,
          List<ExerciseInTrainingEntity> exerciseInTrainingEntityList) =
      RemoveExercise;

  const factory TrainerExerciseListEvent.reorder(
    String clientId,
    String date,
    List<ExerciseInTrainingEntity> exercises,
  ) = Reorder;

  const factory TrainerExerciseListEvent.getNumberOfExercises(
    String clientId,
    String date,
  ) = GetNumberOfExercises;

  const factory TrainerExerciseListEvent.panelExpansion(
      String exerciseId
      ) = PanelExpansion;
}
