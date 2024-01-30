import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perso/app/screens/plan_overview/trainer/widgets/exercise_list/event/trainer_exercise_list_event.dart';
import 'package:perso/app/screens/plan_overview/trainer/widgets/exercise_list/state/trainer_exercise_list_state.dart';
import 'package:perso/core/dependency_injection/get_it.dart';
import 'package:perso/core/models/exercise_in_training_entity.dart';
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
          final exercises = await _exercisesProvider.getExercisesForTrainer(
            event.clientId,
            trainerId,
            event.date,
          );
          emitter(TrainerExerciseListState.exercises(exercises));
        } catch (error) {
          emitter(TrainerExerciseListState.error(error.toString()));
        }
      },
      transformer: restartable(),
    );

    on<AddExercise>((event, emitter) async {
      try {
        await _exercisesService.add(
          clientId: event.clientId,
          trainerId: trainerId,
          date: event.date,
          exerciseEntity:
              event.exerciseEntity.copyWith(index: _currentExerciseIndex),
        );
        _currentExerciseIndex++;
      } catch (error) {
        emitter(TrainerExerciseListState.error(error.toString()));
      }
    });

    on<RemoveExercise>((event, emitter) async {
      try {
        final mutableList = <ExerciseInTrainingEntity>[
          ...event.exerciseInTrainingEntityList,
        ]..remove(event.exerciseInTrainingEntity);
        final updatedIndexesList = mutableList
            .mapIndexed(
              (index, exercise) => exercise.copyWith(
                exerciseEntity: exercise.exerciseEntity.copyWith(
                  index: index,
                ),
              ),
            )
            .toList();

        await _exercisesService.remove(
          clientId: event.clientId,
          trainerId: trainerId,
          date: event.date,
          exerciseInTrainingEntity: event.exerciseInTrainingEntity,
          exerciseInTrainingEntityList: updatedIndexesList,
        );
      } catch (error) {
        emitter(TrainerExerciseListState.error(error.toString()));
      }
    });

    on<GetNumberOfExercises>((event, emitter) async {
      try {
        final numberOfExercises = await _exercisesProvider.getNumberOfExercises(
          event.clientId,
          trainerId,
          event.date,
        );
        _currentExerciseIndex = numberOfExercises;
      } catch (error) {
        emitter(TrainerExerciseListState.error(error.toString()));
      }
    });

    on<Reorder>((event, emitter) async {
      try {
        final reorderedExercises = event.exercises
            .mapIndexed(
              (index, exercise) => exercise.copyWith(
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

    on<PanelExpansion>((event, emitter) async {
      if (_expandedPanels.contains(event.exerciseId)) {
        _expandedPanels.remove(event.exerciseId);
      } else {
        _expandedPanels.add(event.exerciseId);
      }
    });
  }

  final _userSessionModel = getIt.get<UserSessionModel>();
  final _exercisesProvider = getIt.get<FirestoreExerciseProvider>();
  final _exercisesService = getIt.get<FirestoreExerciseService>();
  var _currentExerciseIndex = 0;
  final _expandedPanels = <String>[];
}
