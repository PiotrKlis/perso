import 'package:Perso/app/models/client_data.dart';
import 'package:Perso/app/models/trainer_data.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'profile_edit_event.freezed.dart';

@freezed
class ProfileEditEvent with _$ProfileEditEvent {
  const factory ProfileEditEvent.uploadTrainerData(TrainerData trainerData) = UploadTrainerData;
  const factory ProfileEditEvent.uploadClientData(ClientData clientData) = UploadClientData;
}
