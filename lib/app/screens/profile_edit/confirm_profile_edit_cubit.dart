import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:perso/app/models/editable_client_data.dart';
import 'package:perso/app/screens/profile_edit/confirm_profile_edit_state.dart';
import 'package:perso/app/screens/profile_edit/event/profile_edit_event.dart';
import 'package:perso/app/utils/logger.dart';
import 'package:perso/core/dependency_injection/get_it.dart';
import 'package:perso/core/models/client_entity.dart';
import 'package:perso/core/models/profile_entity.dart';
import 'package:perso/core/models/user_session_model.dart';
import 'package:perso/core/models/user_type.dart';
import 'package:perso/data/clients/clients_service/firestore_clients_service.dart';

@injectable
class ConfirmProfileEditCubit extends Cubit<ConfirmProfileEditState> {
  ConfirmProfileEditCubit() : super(const ConfirmProfileEditState.initial());

  final _userSessionModel = getIt.get<UserSessionModel>();
  final _clientsService = getIt.get<FirestoreClientsService>();
  var _editableClientData = const EditableClientData();
  late UserType userType;

  void confirm(UserType userType) {
    this.userType = userType;
    emit(const ConfirmProfileEditState.sendData());
  }

  void preFillData((UserType, ProfileEntity) userTypeProfileEntityPair) {
    emit(ConfirmProfileEditState.preFillData(userTypeProfileEntityPair));
  }

  void updateName(String name) {
    _editableClientData = _editableClientData.copyWith(name: name);
    _tryToSendData();
  }

  void updateSurname(String surname) {
    _editableClientData = _editableClientData.copyWith(surname: surname);
    _tryToSendData();
  }

  void updateNickname(String nickname) {
    _editableClientData = _editableClientData.copyWith(nickname: nickname);
    _tryToSendData();
  }

  Future<void> _tryToSendData() async {
    if (_editableClientData.isObjectComplete()) {
      try {
        await _sendData(userType);
        await _handleStateEmit(userType);
      } catch (error, stackTrace) {
        emit(ConfirmProfileEditState.error(error.toString()));
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
      imagePath: '',
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
      emit(const ConfirmProfileEditState.editSuccess());
    } else {
      await _updateUserSession(userType);
      emit(const ConfirmProfileEditState.profileCreated());
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
