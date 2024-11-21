import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perso/app/screens/plan_overview/client/event/client_exercise_list_event.dart';
import 'package:perso/app/screens/plan_overview/client/state/client_exercise_list_state.dart';
import 'package:perso/core/dependency_injection/get_it.dart';
import 'package:perso/core/models/user_session_model.dart';
import 'package:perso/data/exercises/exercises_source/firestore_exercise_provider.dart';

class ClientExerciseListBloc
    extends Bloc<ClientExerciseListEvent, ClientExerciseListState> {
  ClientExerciseListBloc() : super(const ClientExerciseListState.loading()) {
    final clientId = _userSessionModel.firebaseUser?.uid ?? '';

    on<GetExercises>(
      (event, emitter) async {
        try {
          emitter(const ClientExerciseListState.loading());
          final exercises = await _exercisesProvider.getExercisesForClient(
            clientId: clientId,
            trainerId: event.trainerId,
            date: event.date,
          );
          exercises.sort(
            (a, b) => a.exerciseEntity.index.compareTo(b.exerciseEntity.index),
          );
          final updatedIndexesExercises = exercises
              .mapIndexed(
                (index, exercise) => exercise.copyWith(
                  exerciseEntity: exercise.exerciseEntity.copyWith(
                    index: index,
                  ),
                ),
              )
              .toList();
          emitter(ClientExerciseListState.exercises(updatedIndexesExercises));
        } catch (error) {
          emitter(ClientExerciseListState.error(error.toString()));
        }
      },
      transformer: restartable(),
    );
  }

  final _userSessionModel = getIt.get<UserSessionModel>();
  final _exercisesProvider = getIt.get<FirestoreExerciseProvider>();
}
