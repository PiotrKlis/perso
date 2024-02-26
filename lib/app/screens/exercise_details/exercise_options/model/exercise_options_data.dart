import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:perso/core/models/exercise_type.dart';

part 'exercise_options_data.freezed.dart';

@freezed
class ExerciseOptionsData with _$ExerciseOptionsData {
  const factory ExerciseOptionsData({
    @Default(ExerciseType.repsBased)ExerciseType exerciseType,
    @Default(8)int reps,
    @Default(3)int sets,
    @Default(60)int time,
    @Default(0)int weight,
    @Default(60)int timeBreak,
    @Default(3)int repsInReserve,
    @Default(7)int rateOfPerceivedExertion,
    @Default(70)int maxPercentage,
    @Default('')String trainerNote,
    @Default('')String supersetName,
  }) = _ExerciseOptionsData;
}
