import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:perso/app/screens/exercise_details/model/exercise_options_data.dart';

part 'exercise_entity.freezed.dart';

@freezed
class ExerciseEntity with _$ExerciseEntity {
  const factory ExerciseEntity({
    required String id,
    required String instructions,
    required int index,
    required List<String> tags,
    required String title,
    required String videoId,
    required ExerciseOptionsData exerciseOptionsData,
  }) = _ExerciseEntity;
}
