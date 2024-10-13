import 'package:freezed_annotation/freezed_annotation.dart';

part 'trainer_client_list_event.freezed.dart';

@freezed
class TrainerClientsListEvent with _$TrainerClientsListEvent {
  const factory TrainerClientsListEvent.loadClientData() = LoadClientData;

  const factory TrainerClientsListEvent.loadTrainerData() = LoadTrainerData;

  const factory TrainerClientsListEvent.activateClient(String clientId) =
      ActivateClient;

  const factory TrainerClientsListEvent.deactivateClient(String clientId) =
      DeactivateClient;

  const factory TrainerClientsListEvent.removeClient(String clientId) =
      RemoveClient;
}
