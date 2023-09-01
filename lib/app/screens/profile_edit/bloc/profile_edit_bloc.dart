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
    on<UploadData>((event, emitter) async {
      //TODO: Add logic for sending the data.
    });
  }
}
