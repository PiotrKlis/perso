import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perso/app/screens/trainer_clients_list/client_section_data.dart';
import 'package:perso/app/screens/trainer_clients_list/event/trainer_client_list_event.dart';
import 'package:perso/app/screens/trainer_clients_list/section_type.dart';
import 'package:perso/app/screens/trainer_clients_list/state/trainer_client_list_state.dart';
import 'package:perso/core/dependency_injection/get_it.dart';
import 'package:perso/core/models/client_entity.dart';
import 'package:perso/data/clients/clients_provider/clients_source.dart';
import 'package:perso/data/clients/clients_provider/firestore_clients_provider.dart';
import 'package:perso/data/trainers/trainers_provider/firestore_trainers_provider.dart';
import 'package:perso/data/trainers/trainers_provider/trainers_source.dart';
import 'package:perso/data/trainers/trainers_service/firestore_trainers_service.dart';
import 'package:perso/data/trainers/trainers_service/trainers_service.dart';
import 'package:perso/data/user_info/user_info_provider.dart';

class TrainerClientsListBloc
    extends Bloc<TrainerClientsListEvent, TrainerClientsListState> {
  TrainerClientsListBloc() : super(const TrainerClientsListState.initial()) {
    on<LoadData>(
      (event, emitter) async {
        try {
          final trainerId = _userInfoProvider.user?.uid ?? '';

          final trainerData = _trainersSource.getTrainerData(trainerId);

          await for (final trainerEntity in trainerData) {
            final activeClients =
                await _addClients(trainerEntity.activeClients);
            final pendingClients =
                await _addClients(trainerEntity.pendingClients);
            final inactiveClients = await _addClients(
              trainerEntity.inactiveClients,
            );
            emitter(
              TrainerClientsListState.clientsData(
                [
                  ClientSectionData(
                    sectionType: SectionType.active,
                    clients: activeClients,
                  ),
                  ClientSectionData(
                    sectionType: SectionType.pending,
                    clients: pendingClients,
                  ),
                  ClientSectionData(
                    sectionType: SectionType.inactive,
                    clients: inactiveClients,
                  ),
                ],
              ),
            );
          }
        } catch (error) {
          emitter(TrainerClientsListState.error(error.toString()));
        }
      },
    );

    on<ActivateClient>((event, emitter) async {
      try {
        await _trainersService.activateClient(event.clientId);
      } catch (error) {
        emitter(TrainerClientsListState.error(error.toString()));
      }
    });
    on<DeactivateClient>((event, emitter) async {
      try {
        await _trainersService.deactivateClient(event.clientId);
      } catch (error) {
        emitter(TrainerClientsListState.error(error.toString()));
      }
    });
    on<RemoveClient>((event, emitter) async {
      try {
        await _trainersService.removeClient(event.clientId);
      } catch (error) {
        emitter(TrainerClientsListState.error(error.toString()));
      }
    });
  }

  final _userInfoProvider = getIt.get<UserInfoProvider>();
  final ClientsSource _clientsSource = getIt.get<FirestoreClientsProvider>();
  final TrainersSource _trainersSource = getIt.get<FirestoreTrainersProvider>();
  final TrainersService _trainersService =
      getIt.get<FirestoreTrainersService>();

  Future<List<ClientEntity>> _addClients(
    List<String> clientIds,
  ) async {
    var clientsList = List<ClientEntity>.empty();
    if (clientIds.first.isNotEmpty) {
      clientsList = await Future.wait(
        clientIds.map(_clientsSource.getClientData),
      );
    }
    return clientsList;
  }
}
