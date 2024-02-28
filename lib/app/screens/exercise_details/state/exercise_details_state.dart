import 'package:freezed_annotation/freezed_annotation.dart';

part 'exercise_details_state.freezed.dart';

@freezed
class ExerciseDetailsState with _$ExerciseDetailsState {
  const factory ExerciseDetailsState.initial() = Initial;
}
