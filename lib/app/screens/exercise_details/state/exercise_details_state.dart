import 'package:freezed_annotation/freezed_annotation.dart';

part 'exercise_details_state.freezed.dart';

@freezed
class ExerciseDetailsState with _$ExerciseDetailsState {
  const factory ExerciseDetailsState.initial() = Initial;
  const factory ExerciseDetailsState.updated() = Updated;
  const factory ExerciseDetailsState.deleteLoading() = DeleteLoading;
  const factory ExerciseDetailsState.saveLoading() = SaveLoading;
}
