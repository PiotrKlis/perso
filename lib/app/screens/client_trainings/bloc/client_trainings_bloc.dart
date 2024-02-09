import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perso/app/screens/client_trainings/event/client_trainings_event.dart';
import 'package:perso/app/screens/client_trainings/state/client_trainings_state.dart';
import 'package:perso/core/dependency_injection/get_it.dart';
import 'package:perso/core/models/user_session_model.dart';
import 'package:perso/data/trainers/trainers_provider/firestore_trainers_provider.dart';

class ClientTrainingBloc
    extends Bloc<ClientTrainingEvent, ClientTrainingState> {
  ClientTrainingBloc() : super(const ClientTrainingState.initial()) {
    final clientId = _userSessionModel.user?.uid ?? '';
    on<LoadTrainings>((event, emitter) async {
      final trainerIdentities = await _trainersProvider.getTrainersForClient(
        clientId,
      );
      emitter(
        ClientTrainingState.trainings(trainerIdentities: trainerIdentities),
      );
    });
  }

  final _trainersProvider = getIt.get<FirestoreTrainersProvider>();
  final _userSessionModel = getIt.get<UserSessionModel>();
}
