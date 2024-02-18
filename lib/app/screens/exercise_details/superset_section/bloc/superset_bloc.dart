import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perso/app/screens/exercise_details/superset_section/event/superset_event.dart';
import 'package:perso/app/screens/exercise_details/superset_section/state/superset_state.dart';
import 'package:perso/core/dependency_injection/get_it.dart';
import 'package:perso/core/models/user_session_model.dart';
import 'package:perso/data/exercises/exercises_service/firestore_exercise_service.dart';

class SupersetBloc extends Bloc<SupersetEvent, SupersetState> {
  SupersetBloc() : super(const SupersetState.initial()) {
    final trainerId = _userSessionModel.user?.uid ?? '';
    final selectedExercises = <String>[];
    on<ChangeCheckboxesVisibility>(
      (event, emitter) async {
        try {
          emitter(
            SupersetState.updateCheckboxesVisibility(
              value: event.shouldCheckboxesBeVisible,
            ),
          );
        } catch (error) {
          emitter(SupersetState.error(error.toString()));
        }
      },
    );

    on<SendSupersetData>(
      (event, emitter) async {
        try {
          final supersetData = {
            for (final exerciseId in selectedExercises)
              exerciseId: event.supersetName,
          };
          await _exerciseService.sendSupersetData(
            trainerId: trainerId,
            clientId: event.clientId,
            date: event.date,
            supersetData: supersetData,
          );
          selectedExercises.clear();
          emitter(SupersetState.sendSuccess(supersetData));
        } catch (error) {
          emitter(SupersetState.error(error.toString()));
        }
      },
    );

    on<AddExercise>(
      (event, emitter) async {
        try {
          selectedExercises.add(event.exerciseId);
        } catch (error) {
          emitter(SupersetState.error(error.toString()));
        }
      },
    );

    on<RemoveExercise>(
      (event, emitter) async {
        try {
          selectedExercises.remove(event.exerciseId);
        } catch (error) {
          emitter(SupersetState.error(error.toString()));
        }
      },
    );
  }

  final _userSessionModel = getIt<UserSessionModel>();
  final _exerciseService = getIt<FirestoreExerciseService>();
}
