import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perso/app/screens/profile_edit/event/profile_edit_event.dart';
import 'package:perso/app/screens/profile_edit/state/profile_edit_state.dart';
import 'package:perso/core/dependency_injection/get_it.dart';
import 'package:perso/core/models/client_entity.dart';
import 'package:perso/core/models/trainer_entity.dart';
import 'package:perso/core/models/user_session_model.dart';
import 'package:perso/core/models/user_type.dart';
import 'package:perso/data/clients/clients_service/firestore_clients_service.dart';
import 'package:perso/data/trainers/trainers_service/firestore_trainers_service.dart';

class ProfileEditBloc extends Bloc<ProfileEditEvent, ProfileEditState> {
  ProfileEditBloc() : super(const ProfileEditState.initial()) {
    on<UploadTrainerData>((event, emitter) async {
      try {
        emitter(const ProfileEditState.loading());
        await _handleTrainerDataUpload(event);
        await _handleStateEmit(emitter, UserType.trainer);
      } catch (error) {
        emitter(ProfileEditState.error(error.toString()));
      }
    });

    on<UploadClientData>((event, emitter) async {
      try {
        emitter(const ProfileEditState.loading());
        await _handleClientDataUpload(event);
        await _handleStateEmit(emitter, UserType.client);
      } catch (error) {
        emitter(ProfileEditState.error(error.toString()));
      }
    });
  }

  Future<void> _handleStateEmit(
    Emitter<ProfileEditState> emitter,
    UserType userType,
  ) async {
    if (_userSessionModel.isProfileCreated) {
      emitter(const ProfileEditState.editSuccess());
    } else {
      await _handleProfileCreation(emitter, userType);
    }
  }

  Future<void> _handleProfileCreation(
    Emitter<ProfileEditState> emitter,
    UserType userType,
  ) async {
    await _userSessionModel.update(
      user: _userSessionModel.user!,
      isProfileCreated: true,
      userType: userType,
      isEmailVerified: _userSessionModel.isEmailVerified,
    );
    emitter(const ProfileEditState.profileCreated());
  }

  final _clientsService = getIt.get<FirestoreClientsService>();
  final _trainersService = getIt.get<FirestoreTrainersService>();
  final _userSessionModel = getIt.get<UserSessionModel>();

  Future<void> _handleTrainerDataUpload(
    UploadTrainerData event,
  ) async {
    if (_userSessionModel.isProfileCreated) {
      await _trainersService.updateData(event.trainerData);
    } else {
      await _handleTrainerProfileCreation(event);
    }
  }

  Future<void> _handleTrainerProfileCreation(
    UploadTrainerData event,
  ) async {
    final id = _userSessionModel.user?.uid ?? '';
    final trainerEntity = TrainerEntity(
      id: id,
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
      pendingClients: [id],
      activeClients: List.empty(),
      inactiveClients: List.empty(),
      imagePath: event.trainerData.imagePath,
      latLng: event.trainerData.latLng,
    );
    await _trainersService.uploadFullTrainerData(trainerEntity);
  }

  Future<void> _handleClientDataUpload(UploadClientData event) async {
    if (_userSessionModel.isProfileCreated) {
      await _clientsService.updateData(event.clientData);
    } else {
      await _handleClientProfileCreation(event);
    }
  }

  Future<void> _handleClientProfileCreation(UploadClientData event) async {
    final clientEntity = ClientEntity(
      id: _userSessionModel.user?.uid ?? '',
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
