import 'package:freezed_annotation/freezed_annotation.dart';

part 'superset_state.freezed.dart';

@freezed
class SupersetState with _$SupersetState {
  const factory SupersetState.initial() = Initial;

  const factory SupersetState.error(String error) = Error;

  const factory SupersetState.sendSuccess(Map<String, String> supersetData) =
      SendSuccess;

  const factory SupersetState.updateCheckboxesVisibility({
    required bool value,
  }) = UpdateCheckboxesVisibility;
}
