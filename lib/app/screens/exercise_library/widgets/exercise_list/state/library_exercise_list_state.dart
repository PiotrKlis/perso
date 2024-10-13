import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:perso/core/models/exercise_entity.dart';

part 'library_exercise_list_state.freezed.dart';

@freezed
class LibraryExerciseListState with _$LibraryExerciseListState {
  const factory LibraryExerciseListState.exercises(
    List<ExerciseEntity> exercises,
  ) = Exercises;

  const factory LibraryExerciseListState.init() = Init;

  const factory LibraryExerciseListState.error(String error) = Error;
}
