import 'package:freezed_annotation/freezed_annotation.dart';

part 'send_exercises_event.freezed.dart';

@freezed
class SendExercisesEvent with _$SendExercisesEvent {
  const factory SendExercisesEvent.sendExercises(
    String clientId,
    String date,
  ) = SendExercises;

  const factory SendExercisesEvent.getExercisesSentDate(
    String clientId,
    String date,
  ) = GetExercisesSentDate;
}
