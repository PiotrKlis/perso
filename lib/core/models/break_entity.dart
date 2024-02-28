import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:perso/core/models/training_entity.dart';

part 'break_entity.freezed.dart';

@freezed
class BreakEntity extends TrainingEntity with _$BreakEntity {
  const factory BreakEntity({
    required int breakTime,
    required int nextExerciseNumber,
    required int totalExercises,
    required String nextExerciseTitle,
  }) = _BreakEntity;
}
