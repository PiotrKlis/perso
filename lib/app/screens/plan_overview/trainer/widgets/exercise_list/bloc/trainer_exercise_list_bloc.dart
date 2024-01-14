import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perso/app/screens/plan_overview/trainer/widgets/exercise_list/event/trainer_exercise_list_event.dart';
import 'package:perso/app/screens/plan_overview/trainer/widgets/exercise_list/state/trainer_exercise_list_state.dart';
import 'package:perso/core/dependency_injection/get_it.dart';
import 'package:perso/core/models/exercise_in_training_entity.dart';
import 'package:perso/core/models/user_session_model.dart';
import 'package:perso/data/exercises/exercises_service/firestore_exercise_service.dart';
import 'package:perso/data/exercises/exercises_source/firestore_exercise_provider.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

class TrainerExerciseListBloc
    extends Bloc<TrainerExerciseListEvent, TrainerExerciseListState> {
  TrainerExerciseListBloc() : super(const TrainerExerciseListState.loading()) {
    final trainerId = _userSessionModel.user?.uid ?? '';

    on<ActivateExercisesStream>(
      (event, emitter) async {
        try {
          emitter(const TrainerExerciseListState.loading());
          // on<VideoStreamPlayPauseEvent>(
          //       (event, emit) async {
          //     if (event.play) {
          //       await emit.forEach(
          //         videoStreamingRepo.videoDataStream,
          //         onData: (VideoData videoStreamData) => VideoStreamState(
          //           currentFrame: videoStreamData,
          //           isPlaying: true,
          //         ),
          //       );
          //     } else {
          //       emit(
          //         VideoStreamState(
          //           currentFrame: state.currentFrame,
          //           isPlaying: false,
          //         ),
          //       );
          //     }
          //   },
          //   // Allow only one of these events to ever be active at once, canceling
          //   // any active `emit.forEach` above.
          //   transformer: restartable(),
          // );
          final stream = _exercisesProvider.getExercisesForTrainer(
            event.clientId,
            trainerId,
            event.date,
          );
          await emitter.forEach(
            stream,
            onData: (exercises) {
              exercises.sort(
                (a, b) =>
                    a.exerciseEntity.index.compareTo(b.exerciseEntity.index),
              );
              return TrainerExerciseListState.exercises(exercises);
            },
          );
        } catch (error) {
          emitter(TrainerExerciseListState.error(error.toString()));
        }
      },
      transformer: restartable(),
    );

    on<EditExercise>((event, emitter) async {
      try {
        await _exercisesService.edit(
          event.clientId,
          trainerId,
          event.exerciseId,
          event.date,
        );
        if (kDebugMode) {
          print('Exercise edited successfully');
        }
      } catch (error) {
        emitter(TrainerExerciseListState.error(error.toString()));
      }
    });

    on<AddExercise>((event, emitter) async {
      try {
        await _exercisesService.add(
          event.clientId,
          trainerId,
          event.date,
          event.exerciseEntity.copyWith(index: _currentExerciseIndex),
        );
        _currentExerciseIndex++;
      } catch (error) {
        emitter(TrainerExerciseListState.error(error.toString()));
      }
    });

    on<RemoveExercise>((event, emitter) async {
      try {
        await _exercisesService.remove(
          event.clientId,
          trainerId,
          event.date,
          event.exerciseId,
        );
        if (kDebugMode) {
          print('Exercise removed successfully');
        }
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

        emitter(TrainerExerciseListState.exercises(reorderedExercises));
        await _exercisesService.reorder(
          event.clientId,
          trainerId,
          event.date,
          reorderedExercises,
        );
      } catch (error) {
        emitter(TrainerExerciseListState.error(error.toString()));
      }
    });
  }

  final _userSessionModel = getIt.get<UserSessionModel>();
  final _exercisesProvider = getIt.get<FirestoreExerciseProvider>();
  final _exercisesService = getIt.get<FirestoreExerciseService>();
  var _currentExerciseIndex = 0;
}
