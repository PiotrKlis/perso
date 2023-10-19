import 'package:perso/app/models/editable_client_data.dart';
import 'package:perso/app/models/editable_trainer_data.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'profile_edit_event.freezed.dart';

@freezed
class ProfileEditEvent with _$ProfileEditEvent {
  const factory ProfileEditEvent.uploadTrainerData(
      EditableTrainerData trainerData) = UploadTrainerData;
  const factory ProfileEditEvent.uploadClientData(
      EditableClientData clientData) = UploadClientData;
}
