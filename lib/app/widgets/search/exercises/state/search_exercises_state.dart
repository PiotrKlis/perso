import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:perso/core/models/exercise_entity.dart';

part 'search_exercises_state.freezed.dart';

@freezed
class SearchExercisesState with _$SearchExercisesState {
  const factory SearchExercisesState.exercises(List<ExerciseEntity> exercises) =
      Exercises;

  const factory SearchExercisesState.empty() = Empty;
  const factory SearchExercisesState.error(String error) = Error;
  const factory SearchExercisesState.init() = Init;
}
