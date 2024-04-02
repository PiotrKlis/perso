import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:perso/core/models/exercise_entity.dart';
import 'package:perso/core/models/training_entity.dart';

part 'exercise_in_progress_entity.freezed.dart';

@freezed
class ExerciseInProgressEntity extends TrainingEntity with _$ExerciseInProgressEntity {
  const factory ExerciseInProgressEntity({
    required String setsRemaining,
    required ExerciseEntity exerciseEntity,
  }) = _ExerciseInProgressEntity;
}