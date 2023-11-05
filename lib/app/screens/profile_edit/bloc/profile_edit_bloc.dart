import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perso/app/screens/profile_edit/event/profile_edit_event.dart';
import 'package:perso/app/screens/profile_edit/state/profile_edit_state.dart';
import 'package:perso/core/dependency_injection/get_it.dart';
import 'package:perso/core/models/client_entity.dart';
import 'package:perso/core/models/trainer_entity.dart';
import 'package:perso/data/clients/clients_service/clients_service.dart';
import 'package:perso/data/clients/clients_service/firestore_clients_service.dart';
import 'package:perso/data/trainers/trainers_service/firestore_trainers_service.dart';
import 'package:perso/data/trainers/trainers_service/trainers_service.dart';
import 'package:perso/data/user_info/user_info_provider.dart';

class ProfileEditBloc extends Bloc<ProfileEditEvent, ProfileEditState> {
  ProfileEditBloc() : super(const ProfileEditState.initial()) {
    on<UploadTrainerData>((event, emitter) async {
      try {
        emitter(const ProfileEditState.loading());
        await _handleTrainerDataUpload(event);
        emitter(const ProfileEditState.success());
      } catch (error) {
        emitter(ProfileEditState.error(error.toString()));
      }
    });

    on<UploadClientData>((event, emitter) async {
      try {
        emitter(const ProfileEditState.loading());
        await _handleClientDataUpload(event);
        emitter(const ProfileEditState.success());
      } catch (error) {
        emitter(ProfileEditState.error(error.toString()));
      }
    });
  }

  final ClientsService _clientsService = getIt.get<FirestoreClientsService>();
  final TrainersService _trainersService =
      getIt.get<FirestoreTrainersService>();
  final UserInfoProvider _userInfoProvider = getIt.get<UserInfoProvider>();

  Future<void> _handleTrainerDataUpload(UploadTrainerData event) async {
    final isProfileCreated = await _userInfoProvider.isProfileCreated();
    if (isProfileCreated) {
      await _trainersService.updateData(event.trainerData);
    } else {
      await _handleTrainerProfileCreation(event);
    }
  }

  Future<void> _handleTrainerProfileCreation(
      UploadTrainerData event,) async {
    final trainerEntity = TrainerEntity(
      id: _userInfoProvider.user?.uid ?? '',
      name: event.trainerData.name,
      surname: event.trainerData.surname,
      nickname: event.trainerData.nickname,
      votesNumber: 0,
      fullBio: event.trainerData.fullBio,
      shortBio: event.trainerData.shortBio,
      languages: event.trainerData.languages,
      rating: 0,
      location: event.trainerData.location,
      categories: event.trainerData.categories,
      reviews: List.empty(),
      pendingClients: List.empty(),
      activeClients: List.empty(),
      inactiveClients: List.empty(),
      imagePath: event.trainerData.imagePath,
      latLng: event.trainerData.latLng,
    );
    await _trainersService.uploadFullTrainerData(trainerEntity);
  }

  Future<void> _handleClientDataUpload(UploadClientData event) async {
    final isProfileCreated = await _userInfoProvider.isProfileCreated();
    if (isProfileCreated) {
      await _clientsService.updateData(event.clientData);
    } else {
      await _handleClientProfileCreation(event);
    }
  }

  Future<void> _handleClientProfileCreation(UploadClientData event) async {
    final clientEntity = ClientEntity(
      id: _userInfoProvider.user?.uid ?? '',
      name: event.clientData.name,
      surname: event.clientData.surname,
      nickname: event.clientData.nickname,
      languages: event.clientData.languages,
      imagePath: event.clientData.imagePath,
      pendingTrainers: List.empty(),
      activeTrainers: List.empty(),
      inactiveTrainers: List.empty(),
    );
    await _clientsService.uploadFullClientData(clientEntity);
  }
}
