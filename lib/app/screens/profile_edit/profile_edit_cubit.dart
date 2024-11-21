import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:perso/app/models/editable_client_data.dart';
import 'package:perso/app/models/editable_trainer_data.dart';
import 'package:perso/app/screens/profile_edit/profile_edit_state.dart';
import 'package:perso/app/utils/logger.dart';
import 'package:perso/core/dependency_injection/get_it.dart';
import 'package:perso/core/models/client_entity.dart';
import 'package:perso/core/models/profile_entity.dart';
import 'package:perso/core/models/trainer_entity.dart';
import 'package:perso/core/models/user_session_model.dart';
import 'package:perso/core/models/user_type.dart';
import 'package:perso/data/clients/clients_service/firestore_clients_service.dart';
import 'package:perso/data/trainers/trainers_service/firestore_trainers_service.dart';

@injectable
class ProfileEditCubit extends Cubit<ProfileEditState> {
  ProfileEditCubit() : super(const ProfileEditState.initial());

  final _userSessionModel = getIt.get<UserSessionModel>();
  final _clientsService = getIt.get<FirestoreClientsService>();
  final _trainersService = getIt.get<FirestoreTrainersService>();
  var _editableClientData = const EditableClientData();
  var _editableTrainerData = const EditableTrainerData();
  late UserType _userType;

  void confirm(UserType userType) {
    _userType = userType;
    emit(const ProfileEditState.sendData());
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
    _editableTrainerData = _editableTrainerData.copyWith(longBio: longBio);
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

  void updateCategories(List<String> categories) {
    _editableTrainerData =
        _editableTrainerData.copyWith(categories: categories);
    _tryToSendData();
  }

  Future<void> _tryToSendData() async {
    if (_userType == UserType.trainer) {
      await _tryToSendTrainerData();
    } else {
      await _tryToSendClientData();
    }
  }

  Future<void> _tryToSendClientData() async {
    if (_editableClientData.isObjectComplete()) {
      try {
        await _handleClientDataUpload();
        await _handleClientStateEmit();
      } catch (error, stackTrace) {
        emit(ProfileEditState.error(error.toString()));
        Logger.error(error, stackTrace);
      }
    }
  }

  Future<void> _tryToSendTrainerData() async {
    if (_editableTrainerData.isObjectComplete()) {
      try {
        await _handleTrainerDataUpload();
        await _handleTrainerStateEmit();
      } catch (error, stackTrace) {
        emit(ProfileEditState.error(error.toString()));
        Logger.error(error, stackTrace);
      }
    }
  }

  Future<void> _handleClientDataUpload() async {
    if (_userSessionModel.isProfileCreated) {
      await _clientsService.updateData(_editableClientData);
    } else {
      await _handleClientProfileCreation();
    }
  }

  Future<void> _handleClientProfileCreation() async {
    final clientEntity = ClientEntity(
      id: _userSessionModel.firebaseUser?.uid ?? '',
      name: _editableClientData.name!,
      surname: _editableClientData.surname!,
      nickname: _editableClientData.nickname!,
      imagePath: _editableClientData.imagePath ?? '',
      pendingTrainers: List.empty(),
      activeTrainers: List.empty(),
      inactiveTrainers: List.empty(),
      userType: UserType.client,
    );
    await _clientsService.uploadFullClientData(clientEntity);
  }

  Future<void> _handleTrainerDataUpload() async {
    if (_userSessionModel.isProfileCreated) {
      await _trainersService.updateData(_editableTrainerData);
    } else {
      await _handleTrainerProfileCreation();
    }
  }

  Future<void> _handleTrainerProfileCreation() async {
    final id = _userSessionModel.firebaseUser?.uid ?? '';
    final trainerEntity = TrainerEntity(
      id: id,
      name: _editableTrainerData.name!,
      surname: _editableTrainerData.surname!,
      nickname: _editableTrainerData.nickname!,
      votesNumber: 0,
      longBio: _editableTrainerData.longBio!,
      shortBio: _editableTrainerData.shortBio!,
      languages: _editableTrainerData.languages!,
      rating: 0,
      address: _editableTrainerData.address!,
      categories: _editableTrainerData.categories!,
      reviews: List.empty(),
      pendingClients: [id],
      activeClients: List.empty(),
      inactiveClients: List.empty(),
      imagePath: _editableTrainerData.imagePath!,
      latLng: _editableTrainerData.latLng!,
      userType: UserType.trainer,
    );
    await _trainersService.uploadFullTrainerData(trainerEntity);
  }

  Future<void> _handleClientStateEmit() async {
    if (_userSessionModel.isProfileCreated) {
      emit(const ProfileEditState.editSuccess());
    } else {
      final clientEntity = _userSessionModel.profileEntity! as ClientEntity;
      final updatedClientEntity = clientEntity.copyWith(
        imagePath: _editableTrainerData.imagePath!,
        name: _editableTrainerData.name!,
        surname: _editableTrainerData.surname!,
        nickname: _editableTrainerData.nickname!,
      );
      await _updateUserSession(_userType, updatedClientEntity);
      emit(const ProfileEditState.profileCreated());
    }
  }

  Future<void> _handleTrainerStateEmit() async {
    if (_userSessionModel.isProfileCreated) {
      emit(const ProfileEditState.editSuccess());
    } else {
      final trainerEntity = _userSessionModel.profileEntity! as TrainerEntity;
      final updatedTrainerEntity = trainerEntity.copyWith(
        imagePath: _editableTrainerData.imagePath!,
        languages: _editableTrainerData.languages!,
        name: _editableTrainerData.name!,
        surname: _editableTrainerData.surname!,
        nickname: _editableTrainerData.nickname!,
        address: _editableTrainerData.address!,
        shortBio: _editableTrainerData.shortBio!,
        longBio: _editableTrainerData.longBio!,
        categories: _editableTrainerData.categories!,
        latLng: _editableTrainerData.latLng!,
      );
      await _updateUserSession(_userType, updatedTrainerEntity);
      emit(const ProfileEditState.profileCreated());
    }
  }

  Future<void> _updateUserSession(
    UserType userType,
    ProfileEntity profileEntity,
  ) async {
    await _userSessionModel.update(
      firebaseUser: _userSessionModel.firebaseUser!,
      isProfileCreated: true,
      userType: userType,
      isEmailVerified: _userSessionModel.isEmailVerified,
      profileEntity: profileEntity,
    );
  }
}
