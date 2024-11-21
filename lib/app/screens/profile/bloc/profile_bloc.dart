import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perso/app/screens/profile/event/profile_event.dart';
import 'package:perso/app/screens/profile/state/profile_state.dart';
import 'package:perso/core/dependency_injection/get_it.dart';
import 'package:perso/core/models/profile_entity.dart';
import 'package:perso/core/models/user_session_model.dart';
import 'package:perso/core/models/user_type.dart';
import 'package:perso/data/auth/auth_service.dart';
import 'package:perso/data/clients/clients_provider/firestore_clients_provider.dart';
import 'package:perso/data/trainers/trainers_provider/firestore_trainers_provider.dart';
import 'package:perso/data/user_info/user_info_provider.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(const ProfileState.initial()) {
    on<LoadData>((event, emitter) async {
      final profileId = _userSessionModel.firebaseUser?.uid ?? '';
      final userType = _userSessionModel.profileEntity?.userType;
      ProfileEntity profileEntity;
      if (userType == UserType.trainer) {
        profileEntity = await _trainersProvider.getTrainer(profileId);
      } else {
        profileEntity = await _clientsProvider.getClientData(profileId);
      }
      emitter(ProfileState.data(profileEntity));
    });

    on<Logout>((event, emitter) async {
      final authService = getIt.get<AuthService>();
      await authService.logout();
    });
  }

  final _trainersProvider = getIt.get<FirestoreTrainersProvider>();
  final _clientsProvider = getIt.get<FirestoreClientsProvider>();
  final _userSessionModel = getIt.get<UserSessionModel>();
}
