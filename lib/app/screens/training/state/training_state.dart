import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:perso/core/models/break_entity.dart';
import 'package:perso/core/models/exercise_in_progress_entity.dart';

part 'training_state.freezed.dart';

@freezed
class TrainingState with _$TrainingState {
  const factory TrainingState.initial() = Initial;

  const factory TrainingState.exerciseInProgress(
    ExerciseInProgressEntity exerciseInProgressEntity,
  ) = ExerciseInProgress;

  const factory TrainingState.trainingBreak(BreakEntity breakEntity) =
      TrainingBreak;

  const factory TrainingState.finished() = Finished;
}
