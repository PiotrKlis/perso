import 'package:freezed_annotation/freezed_annotation.dart';

part 'client_exercise_list_event.freezed.dart';

@freezed
class ClientExerciseListEvent with _$ClientExerciseListEvent {
  const factory ClientExerciseListEvent.getExercises({
    required String trainerId,
    required String date,
  }) = GetExercises;
}
