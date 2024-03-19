import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perso/app/screens/plan_overview/trainer/widgets/exercise_list/event/trainer_exercise_list_event.dart';
import 'package:perso/app/screens/plan_overview/trainer/widgets/exercise_list/state/trainer_exercise_list_state.dart';
import 'package:perso/core/dependency_injection/get_it.dart';
import 'package:perso/core/models/user_session_model.dart';
import 'package:perso/data/exercises/exercises_service/firestore_exercise_service.dart';
import 'package:perso/data/exercises/exercises_source/firestore_exercise_provider.dart';

class TrainerExerciseListBloc
    extends Bloc<TrainerExerciseListEvent, TrainerExerciseListState> {
  TrainerExerciseListBloc() : super(const TrainerExerciseListState.loading()) {
    final trainerId = _userSessionModel.user?.uid ?? '';

    on<FetchExercises>(
      (event, emitter) async {
        try {
          emitter(const TrainerExerciseListState.loading());
          final exercises = await _exercisesProvider.getExercises(
            clientId: event.clientId,
            trainerId: trainerId,
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
          emitter(TrainerExerciseListState.exercises(updatedIndexesExercises));
        } catch (error) {
          emitter(TrainerExerciseListState.error(error.toString()));
        }
      },
      transformer: restartable(),
    );

    on<Reorder>((event, emitter) async {
      try {
        final reorderedExercises = event.exercises
            .mapIndexed(
              (index, exercise) =>
              exercise.copyWith(
                exerciseEntity: exercise.exerciseEntity.copyWith(
                  index: index,
                ),
              ),
        )
            .toList();

        emitter(
          TrainerExerciseListState.exercises(
            reorderedExercises,
          ),
        );
        await _exercisesService.reorder(
          clientId: event.clientId,
          trainerId: trainerId,
          date: event.date,
          exercises: reorderedExercises,
        );
      } catch (error) {
        emitter(TrainerExerciseListState.error(error.toString()));
      }
    });
  }

  final _userSessionModel = getIt.get<UserSessionModel>();
  final _exercisesProvider = getIt.get<FirestoreExerciseProvider>();
  final _exercisesService = getIt.get<FirestoreExerciseService>();
}
