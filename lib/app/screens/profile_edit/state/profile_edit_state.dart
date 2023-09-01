import 'package:freezed_annotation/freezed_annotation.dart';
part 'profile_edit_state.freezed.dart';

@freezed
class ProfileEditState with _$ProfileEditState {
  const factory ProfileEditState.initial() = Initial;
  const factory ProfileEditState.error() = Error;
  const factory ProfileEditState.success() = Success;
}
