import 'package:freezed_annotation/freezed_annotation.dart';
part 'profile_edit_event.freezed.dart';

@freezed
class ProfileEditEvent with _$ProfileEditEvent {
  const factory ProfileEditEvent.uploadData() = UploadData;
}
