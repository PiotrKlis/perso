import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:perso/core/models/exercise_type.dart';

part 'exercise_entity.freezed.dart';

@freezed
class ExerciseEntity with _$ExerciseEntity {
  const factory ExerciseEntity({
    required String id,
    required String description,
    required int index,
    required ExerciseType exerciseType,
    required int reps,
    required int sets,
    required List<String> tags,
    required String time,
    required String title,
    required String videoId,
    required int timeBreak,
    required String supersetName,
  }) = _ExerciseEntity;
}
