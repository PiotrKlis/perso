import 'package:freezed_annotation/freezed_annotation.dart';
part 'profile_edit_state.freezed.dart';

@freezed
class ProfileEditState with _$ProfileEditState {
  const factory ProfileEditState.initial() = Initial;
  const factory ProfileEditState.loading() = Loading;
  const factory ProfileEditState.error(String error) = Error;
  const factory ProfileEditState.editSuccess() = EditSuccess;
  const factory ProfileEditState.profileCreated() = ProfileCreated;
}
