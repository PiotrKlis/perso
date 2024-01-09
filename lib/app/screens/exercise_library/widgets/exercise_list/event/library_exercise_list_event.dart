import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:perso/core/models/exercise_entity.dart';

part 'library_exercise_list_event.freezed.dart';

@freezed
class LibraryExerciseListEvent with _$LibraryExerciseListEvent {
  const factory LibraryExerciseListEvent.getAllLibraryExercises() =
      GetAllLibraryExercises;

  const factory LibraryExerciseListEvent.add(
      String clientId, String date, ExerciseEntity exerciseEntity) = Add;

// const factory LibraryExerciseListEvent.getExercises(
//   String clientId,
//   String trainerId,
//   String date,
// ) = GetExercises;
//
// const factory LibraryExerciseListEvent.getNumberOfExercises(
//   String clientId,
//   String date,
// ) = GetNumberOfExercises;
}
