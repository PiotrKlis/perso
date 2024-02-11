import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:perso/core/models/exercise_entity.dart';

part 'training_state.freezed.dart';

@freezed
class TrainingState with _$TrainingState {
  const factory TrainingState.initial() = Initial;

  const factory TrainingState.error(String error) = Error;

  const factory TrainingState.exerciseInProgress(
    ExerciseEntity exerciseEntity,
  ) = ExerciseInProgress;

  const factory TrainingState.trainingBreak() = TrainingBreak;

  const factory TrainingState.loading() = Loading;
}
