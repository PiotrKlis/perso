import 'package:Perso/app/models/trainer_card/trainer_entity.dart';
import 'package:Perso/app/screens/profile_edit/event/profile_edit_event.dart';
import 'package:Perso/app/screens/profile_edit/state/profile_edit_state.dart';
import 'package:Perso/data/clients/clients_service.dart';
import 'package:Perso/data/clients/firestore_clients_service.dart';
import 'package:Perso/data/shared_prefs/perso_shared_prefs.dart';
import 'package:Perso/data/trainers/firestore_trainers_service.dart';
import 'package:Perso/data/trainers/trainers_service.dart';
import 'package:Perso/data/user_info/user_info_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class ProfileEditBloc extends Bloc<ProfileEditEvent, ProfileEditState> {
  final ClientsService _clientsService = GetIt.I.get<FirestoreClientsService>();
  final TrainersService _trainersService =
      GetIt.I.get<FirestoreTrainersService>();
  final _sharedPrefs = GetIt.I.get<PersoSharedPrefs>();
  final UserInfoProvider _userInfoProvider = GetIt.I.get<UserInfoProvider>();

  ProfileEditBloc(ProfileEditState initialState) : super(initialState) {
    on<UploadTrainerData>((event, emitter) async {
      try {
        emitter.call(const ProfileEditState.loading());
        await _sendTrainerData(event);
        emitter.call(const ProfileEditState.success());
      } catch (error) {
        emitter.call(ProfileEditState.error(error.toString()));
      }
    });

    on<UploadClientData>((event, emitter) async {
      try {
        emitter.call(const ProfileEditState.loading());
        await _handleClientImageUpload(event.clientData.image);
        await _clientsService.uploadData(event.clientData);
        emitter.call(const ProfileEditState.success());
      } catch (error) {
        emitter.call(ProfileEditState.error(error.toString()));
      }
    });
  }

  Future<void> _sendTrainerData(UploadTrainerData event) async {
    await _handleTrainerImageUpload(event.trainerData.imagePath);
    await _handleTrainerDataUpload(event);
  }

  Future<void> _handleTrainerDataUpload(UploadTrainerData event) async {
    var isFirstProfileCreation =
        !_sharedPrefs.getBool(PersoSharedPrefs.isProfileCreatedKey);
    if (isFirstProfileCreation) {
      await _handleFirstProfileCreation(event);
      _sharedPrefs.setBool(PersoSharedPrefs.isProfileCreatedKey, true);
    } else {
      await _trainersService.updateData(event.trainerData);
    }
  }

  Future<void> _handleClientImageUpload(String? imagePath) async {
    String path = imagePath ?? "";
    if (path.isNotEmpty) {
      await _clientsService.uploadPhoto(path);
    }
  }

  Future<void> _handleTrainerImageUpload(String? imagePath) async {
    String path = imagePath ?? "";
    if (path.isNotEmpty) {
      await _trainersService.uploadPhoto(path);
    }
  }

  Future<void> _handleFirstProfileCreation(UploadTrainerData event) async {
    TrainerEntity trainerEntity = TrainerEntity(
        id: _userInfoProvider.user?.uid ?? "",
        image: "",
        name: event.trainerData.name,
        surname: event.trainerData.surname,
        nickname: event.trainerData.nickname,
        votesNumber: 0,
        fullBio: event.trainerData.fullBio,
        shortBio: event.trainerData.shortBio,
        email: _userInfoProvider.user?.email ?? "",
        languages: event.trainerData.languages,
        rating: 0.0,
        location: event.trainerData.location,
        phoneNumber: event.trainerData.phoneNumber,
        reviews: List.empty(),
        categories: event.trainerData.categories);
    await _trainersService.setData(trainerEntity);
  }
}
