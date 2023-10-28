import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:perso/app/screens/trainer_clients_list/client_section_data.dart';
import 'package:perso/app/screens/trainer_clients_list/trainer_clients_list_screen.dart';

part 'trainer_client_list_state.freezed.dart';

@freezed
class TrainerClientsListState with _$TrainerClientsListState {
  const factory TrainerClientsListState.initial() = Initial;

  const factory TrainerClientsListState.error(String error) = Error;

  const factory TrainerClientsListState.clientsData(
    List<ClientSectionData> clientsData,
  ) = ClientsData;
}
