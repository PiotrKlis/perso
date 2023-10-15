import 'package:Perso/app/screens/profile_edit/event/profile_edit_event.dart';
import 'package:Perso/app/screens/profile_edit/state/profile_edit_state.dart';
import 'package:Perso/core/dependency_injection/get_it_config.dart';
import 'package:Perso/core/models/trainer_entity.dart';
import 'package:Perso/data/clients/clients_service.dart';
import 'package:Perso/data/clients/firestore_clients_service.dart';
import 'package:Perso/data/trainers/firestore_trainers_service.dart';
import 'package:Perso/data/trainers/trainers_service.dart';
import 'package:Perso/data/user_info/user_info_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileEditBloc extends Bloc<ProfileEditEvent, ProfileEditState> {
  final ClientsService _clientsService = getIt.get<FirestoreClientsService>();
  final TrainersService _trainersService =
      getIt.get<FirestoreTrainersService>();
  final UserInfoProvider _userInfoProvider = getIt.get<UserInfoProvider>();

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
        await _clientsService.uploadData(event.clientData);
        emitter(const ProfileEditState.success());
      } catch (error) {
        emitter(ProfileEditState.error(error.toString()));
      }
    });
  }

  Future<void> _handleTrainerDataUpload(UploadTrainerData event) async {
    var isProfileCreated = await _userInfoProvider.isProfileCreated();
    if (isProfileCreated) {
      await _trainersService.updateData(event.trainerData);
    } else {
      await _handleFirstProfileCreation(event);
    }
  }

  Future<void> _handleFirstProfileCreation(UploadTrainerData event) async {
    TrainerEntity trainerEntity = TrainerEntity(
        id: _userInfoProvider.user?.uid ?? "",
        name: event.trainerData.name,
        surname: event.trainerData.surname,
        nickname: event.trainerData.nickname,
        votesNumber: 0,
        fullBio: event.trainerData.fullBio,
        shortBio: event.trainerData.shortBio,
        languages: event.trainerData.languages,
        rating: 0.0,
        location: event.trainerData.location,
        categories: event.trainerData.categories,
        reviews: List.empty(),
        pendingRequests: List.empty(),
        activeClients: List.empty(),
        inactiveClients: List.empty(),
        imagePath: event.trainerData.imagePath,
        latLng: event.trainerData.latLng);
    await _trainersService.setData(trainerEntity);
  }
}
