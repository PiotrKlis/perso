import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:perso/core/models/tag_entity.dart';
part 'exercise_entity.freezed.dart';

@freezed
class ExerciseEntity with _$ExerciseEntity {
  const factory ExerciseEntity({
    required String id,
    required String description,
    required int index,
    required bool isRepsBased,
    required bool isTimeBased,
    required int reps,
    required int sets,
    required List<TagEntity> tags,
    required String time,
    required String title,
    required String videoId,
  }) = _ExerciseEntity;
}
