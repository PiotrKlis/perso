import 'package:freezed_annotation/freezed_annotation.dart';

part 'send_exercises_state.freezed.dart';

@freezed
class SendExercisesState with _$SendExercisesState {
  const factory SendExercisesState.initial() = Initial;

  const factory SendExercisesState.sendingInProgress() = SendingInProgress;

  const factory SendExercisesState.exerciseSentDate(String date) =
      ExerciseSentDate;

  const factory SendExercisesState.error(String data) = Error;
}
