import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perso/app/screens/plan_overview/client/event/client_exercise_list_event.dart';
import 'package:perso/app/screens/plan_overview/client/state/client_exercise_list_state.dart';
import 'package:perso/core/dependency_injection/get_it.dart';
import 'package:perso/core/models/user_session_model.dart';
import 'package:perso/data/exercises/exercises_source/firestore_exercise_provider.dart';

class ClientExerciseListBloc
    extends Bloc<ClientExerciseListEvent, ClientExerciseListState> {
  ClientExerciseListBloc() : super(const ClientExerciseListState.loading()) {
    final clientId = _userSessionModel.user?.uid ?? '';

    on<GetExercises>((event, emitter) async {
      final exercises = await _exercisesProvider.getExercisesForClient(
          clientId: clientId, date: event.date, trainerId: event.trainerId);
      emitter(ClientExerciseListState.exercises(exercises));
    });
  }

  final _userSessionModel = getIt.get<UserSessionModel>();
  final _exercisesProvider = getIt.get<FirestoreExerciseProvider>();
}
