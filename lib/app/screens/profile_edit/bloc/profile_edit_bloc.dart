import 'package:Perso/app/screens/profile_edit/event/profile_edit_event.dart';
import 'package:Perso/app/screens/profile_edit/state/profile_edit_state.dart';
import 'package:Perso/data/clients/clients_service.dart';
import 'package:Perso/data/clients/firestore_clients_service.dart';
import 'package:Perso/data/trainers/firestore_trainers_service.dart';
import 'package:Perso/data/trainers/trainers_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class ProfileEditBloc extends Bloc<ProfileEditEvent, ProfileEditState> {
  final ClientsService _clientsService = GetIt.I.get<FirestoreClientsService>();
  final TrainersService _trainersService =
      GetIt.I.get<FirestoreTrainersService>();

  ProfileEditBloc(ProfileEditState initialState) : super(initialState) {
    on<UploadTrainerData>((event, emitter) async {
      try {
        emitter.call(const ProfileEditState.loading());
        await _trainersService.uploadData(event.trainerData);
        emitter.call(const ProfileEditState.success());
      } catch (error) {
        emitter.call(ProfileEditState.error(error.toString()));
      }
    });

    on<UploadClientData>((event, emitter) async {
      event.clientData;
    });
  }
}
