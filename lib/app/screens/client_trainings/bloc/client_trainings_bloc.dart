import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perso/app/screens/client_trainings/event/client_trainings_event.dart';
import 'package:perso/app/screens/client_trainings/state/client_trainings_state.dart';
import 'package:perso/core/dependency_injection/get_it.dart';
import 'package:perso/core/models/user_session_model.dart';
import 'package:perso/data/exercises/exercises_source/firestore_exercise_provider.dart';

class ClientTrainingBloc
    extends Bloc<ClientTrainingEvent, ClientTrainingState> {
  ClientTrainingBloc() : super(const ClientTrainingState.initial()) {
    final clientId = _userSessionModel.user?.uid ?? '';
    on<LoadTrainings>((event, emitter) async {
      final trainerNicknames = await _exerciseProvider.getTrainersForClient(
        clientId,
      );
      emitter(
        ClientTrainingState.trainings(trainerNicknames: trainerNicknames),
      );
    });
  }

  final _exerciseProvider = getIt.get<FirestoreExerciseProvider>();
  final _userSessionModel = getIt.get<UserSessionModel>();
}
