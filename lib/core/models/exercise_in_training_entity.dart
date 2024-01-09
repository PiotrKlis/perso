import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:perso/core/models/exercise_entity.dart';
part 'exercise_in_training_entity.freezed.dart';

@freezed
class ExerciseInTrainingEntity with _$ExerciseInTrainingEntity {
  const factory ExerciseInTrainingEntity({
    required String id,
    required ExerciseEntity exerciseEntity,
  }) = _ExerciseInTrainingEntity;
}
