import 'package:freezed_annotation/freezed_annotation.dart';

part 'superset_event.freezed.dart';

@freezed
class SupersetEvent with _$SupersetEvent {
  const factory SupersetEvent.changeCheckboxesVisibility({
    required bool shouldCheckboxesBeVisible,
  }) = ChangeCheckboxesVisibility;

  const factory SupersetEvent.sendSupersetData({
    required String clientId,
    required String date,
    required String supersetName,
  }) = SendSupersetData;

  const factory SupersetEvent.addExercise({
    required String exerciseId,
  }) = AddExercise;

  const factory SupersetEvent.removeExercise({
    required String exerciseId,
  }) = RemoveExercise;
}
