import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:perso/core/models/exercise_type.dart';

part 'exercise_options_data.freezed.dart';

@freezed
class ExerciseOptionsData with _$ExerciseOptionsData {
  const factory ExerciseOptionsData({
    ExerciseType? exerciseType,
    int reps,
    int? sets,
    int? time,
    String? weight,
    int? timeBreak,
    int? repsInReserve,
    int? rateOfPerceivedExertion,
    String? maxPercentage,
    String? trainerNote,
    String? supersetName,
  }) = _ExerciseOptionsData;
}
