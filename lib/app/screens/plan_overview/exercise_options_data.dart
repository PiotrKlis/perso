import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:perso/core/models/exercise_type.dart';
part 'exercise_options_data.freezed.dart';

@freezed
class ExerciseOptionsData with _$ExerciseOptionsData {
  const factory ExerciseOptionsData({
  required ExerciseType exerciseType,
    required String reps,
    required String sets,
    required String time,
  }) = _ExerciseOptionsData;
}