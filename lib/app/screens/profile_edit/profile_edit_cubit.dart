import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:perso/app/models/editable_client_data.dart';
import 'package:perso/app/models/editable_trainer_data.dart';
import 'package:perso/app/screens/profile_edit/event/profile_edit_event.dart';
import 'package:perso/app/screens/profile_edit/profile_edit_state.dart';
import 'package:perso/app/utils/logger.dart';
import 'package:perso/core/dependency_injection/get_it.dart';
import 'package:perso/core/models/client_entity.dart';
import 'package:perso/core/models/profile_entity.dart';
import 'package:perso/core/models/user_session_model.dart';
import 'package:perso/core/models/user_type.dart';
import 'package:perso/data/clients/clients_service/firestore_clients_service.dart';

@injectable
class ProfileEditCubit extends Cubit<ProfileEditState> {
  ProfileEditCubit() : super(const ProfileEditState.initial());

  final _userSessionModel = getIt.get<UserSessionModel>();
  final _clientsService = getIt.get<FirestoreClientsService>();
  var _editableClientData = const EditableClientData();
  var _editableTrainerData = const EditableTrainerData();
  late UserType _userType;

  void confirm(UserType userType) {
    _userType = userType;
    emit(const ProfileEditState.sendData());
  }

  void preFillData((UserType, ProfileEntity) userTypeProfileEntityPair) {
    emit(ProfileEditState.preFillData(userTypeProfileEntityPair.$2));
  }

  void updateName(String name) {
    if (_userType == UserType.trainer) {
      _editableTrainerData = _editableTrainerData.copyWith(name: name);
    } else {
      _editableClientData = _editableClientData.copyWith(name: name);
    }
    _tryToSendData();
  }

  void updateSurname(String surname) {
    if (_userType == UserType.trainer) {
      _editableTrainerData = _editableTrainerData.copyWith(surname: surname);
    } else {
      _editableClientData = _editableClientData.copyWith(surname: surname);
    }
    _tryToSendData();
  }

  void updateNickname(String nickname) {
    if (_userType == UserType.trainer) {
      _editableTrainerData = _editableTrainerData.copyWith(nickname: nickname);
    } else {
      _editableClientData = _editableClientData.copyWith(nickname: nickname);
    }
    _tryToSendData();
  }

  void updateImageUrl(String url) {
    if (_userType == UserType.trainer) {
      _editableTrainerData = _editableTrainerData.copyWith(imagePath: url);
    } else {
      _editableClientData = _editableClientData.copyWith(imagePath: url);
    }
    _tryToSendData();
  }

  void updateShortBio(String shortBio) {
    _editableTrainerData = _editableTrainerData.copyWith(shortBio: shortBio);
    _tryToSendData();
  }

  void updateLongBio(String longBio) {
    _editableTrainerData = _editableTrainerData.copyWith(fullBio: longBio);
    _tryToSendData();
  }

  void updateAddress(String address) {
    _editableTrainerData = _editableTrainerData.copyWith(address: address);
    _tryToSendData();
  }

  void updateLatLng(LatLng latLng) {
    _editableTrainerData = _editableTrainerData.copyWith(latLng: latLng);
    _tryToSendData();
  }

  void updateLanguages(List<String> languages) {
    _editableTrainerData = _editableTrainerData.copyWith(languages: languages);
    _tryToSendData();
  }

  Future<void> _tryToSendData() async {
    if (_editableClientData.isObjectComplete()) {
      try {
        await _sendData(_userType);
        await _handleStateEmit(_userType);
      } catch (error, stackTrace) {
        emit(ProfileEditState.error(error.toString()));
        Logger.error(error, stackTrace);
      }
    }
  }

  Future<void> _sendData(UserType userType) async {
    if (userType == UserType.trainer) {
      await _handleTrainerDataUpload();
    } else {
      await _handleClientDataUpload();
    }
  }

  Future<void> _handleClientDataUpload() async {
    if (_userSessionModel.isProfileCreated) {
      await _clientsService.updateData(_editableClientData);
    } else {
      await _handleClientProfileCreation(_editableClientData);
    }
  }

  Future<void> _handleClientProfileCreation(
    EditableClientData editableClientData,
  ) async {
    final clientEntity = ClientEntity(
      id: _userSessionModel.user?.uid ?? '',
      name: editableClientData.name!,
      surname: editableClientData.surname!,
      nickname: editableClientData.nickname!,
      imagePath: editableClientData.imagePath ?? '',
      pendingTrainers: List.empty(),
      activeTrainers: List.empty(),
      inactiveTrainers: List.empty(),
    );
    await _clientsService.uploadFullClientData(clientEntity);
  }

  Future<void> _handleTrainerDataUpload() async {
    if (_userSessionModel.isProfileCreated) {
      // await _trainersService.updateData(event.trainerData);
    } else {
      // await _handleTrainerProfileCreation(event);
    }
  }

  Future<void> _handleTrainerProfileCreation(
    UploadTrainerData event,
  ) async {
    final id = _userSessionModel.user?.uid ?? '';
    // final trainerEntity = TrainerEntity(
    //   id: id,
    //   name: event.trainerData.name,
    //   surname: event.trainerData.surname,
    //   nickname: event.trainerData.nickname,
    //   votesNumber: 0,
    //   fullBio: event.trainerData.fullBio,
    //   shortBio: event.trainerData.shortBio,
    //   languages: event.trainerData.languages,
    //   rating: 0,
    //   location: event.trainerData.location,
    //   categories: event.trainerData.categories,
    //   reviews: List.empty(),
    //   pendingClients: [id],
    //   activeClients: List.empty(),
    //   inactiveClients: List.empty(),
    //   imagePath: event.trainerData.imagePath,
    //   latLng: event.trainerData.latLng,
    // );
    // await _trainersService.uploadFullTrainerData(trainerEntity);
  }

  Future<void> _handleStateEmit(
    UserType userType,
  ) async {
    if (_userSessionModel.isProfileCreated) {
      emit(const ProfileEditState.editSuccess());
    } else {
      await _updateUserSession(userType);
      emit(const ProfileEditState.profileCreated());
    }
  }

  Future<void> _updateUserSession(
    UserType userType,
  ) async {
    await _userSessionModel.update(
      user: _userSessionModel.user!,
      isProfileCreated: true,
      userType: userType,
      isEmailVerified: _userSessionModel.isEmailVerified,
    );
  }
}
