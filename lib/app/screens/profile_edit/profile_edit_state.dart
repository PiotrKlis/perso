import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:perso/core/models/profile_entity.dart';

part 'profile_edit_state.freezed.dart';

@freezed
class ProfileEditState with _$ProfileEditState {
  const factory ProfileEditState.initial() = Initial;

  const factory ProfileEditState.sendData() = SendData;

  const factory ProfileEditState.error(String error) = Error;

  const factory ProfileEditState.editSuccess() = EditSuccess;

  const factory ProfileEditState.profileCreated() = ProfileCreated;
}
