import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perso/app/widgets/exercise_list/client/event/client_exercise_list_event.dart';
import 'package:perso/app/widgets/exercise_list/client/state/client_exercise_list_state.dart';
import 'package:perso/core/dependency_injection/get_it.dart';
import 'package:perso/core/models/user_session_model.dart';
import 'package:perso/data/exercises/exercises_service/firestore_exercise_service.dart';
import 'package:perso/data/exercises/exercises_source/firestore_exercise_provider.dart';

//TODO: Różne blocki per screen? Client/Trainer/Library
class ClientExerciseListBloc
    extends Bloc<ClientExerciseListEvent, ClientExerciseListState> {
  ClientExerciseListBloc() : super(const ClientExerciseListState.init()) {
    final _clientId = _userSessionModel.user?.uid ?? '';


    on<GetExercises>((event, emitter) async {
      // try {
      //   final exercisesStream = _exercisesProvider.getExercisesForTrainer(
      //     event._clientId,
      //     trainerId,
      //     event.date,
      //   );
      //   await for (final exercises in exercisesStream) {
      //     exercises.sort((a, b) =>
      //         a.exerciseEntity.index.compareTo(b.exerciseEntity.index));
      //     emitter(TrainerExerciseListState.exercises(exercises));
      //   }
      // } catch (error) {
      //   emitter(TrainerExerciseListState.error(error.toString()));
      // }
    });
  }

  final _userSessionModel = getIt.get<UserSessionModel>();
  final _exercisesProvider = getIt.get<FirestoreExerciseProvider>();
  final _exercisesService = getIt.get<FirestoreExerciseService>();
  var _currentExerciseIndex = 0;
}
