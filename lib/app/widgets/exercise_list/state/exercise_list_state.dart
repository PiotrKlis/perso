import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:perso/core/models/exercise_entity.dart';

part 'exercise_list_state.freezed.dart';

@freezed
class ExerciseListState with _$ExerciseListState {
  const factory ExerciseListState.exercises(List<ExerciseEntity> exercises) =
      Exercises;

  const factory ExerciseListState.init() = Init;
  const factory ExerciseListState.error(String error) = Error;
}
