import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perso/app/screens/training/event/training_event.dart';
import 'package:perso/app/screens/training/state/training_state.dart';
import 'package:perso/core/dependency_injection/get_it.dart';
import 'package:perso/core/models/break_entity.dart';
import 'package:perso/core/models/exercise_entity.dart';
import 'package:perso/core/models/training_entity.dart';
import 'package:perso/data/chat/chat_service.dart';
import 'package:perso/data/exercises/exercises_service/firestore_exercise_service.dart';

class TrainingBloc extends Bloc<TrainingEvent, TrainingState> {
  TrainingBloc() : super(const TrainingState.initial()) {
    on<LoadTraining>((event, emitter) async {
      final addedSupersets = <String>[];
      for (final exerciseEntity in event.exercises) {
        final supersetName = exerciseEntity.exerciseOptionsData.supersetName;
        if (supersetName.isNotEmpty && !addedSupersets.contains(supersetName)) {
          _handleSuperset(
            addedSupersets,
            supersetName,
            event.exercises,
            exerciseEntity,
            _training,
          );
          break;
        }
        for (var index = 0;
            index < exerciseEntity.exerciseOptionsData.sets;
            index++) {
          _training.add(exerciseEntity);
          if (index < exerciseEntity.exerciseOptionsData.sets - 1) {
            _training.add(
              BreakEntity(
                breakTime: exerciseEntity.exerciseOptionsData.timeBreak,
              ),
            );
          }
        }
      }
      emitter(
        TrainingState.exerciseInProgress(
          _training[currentTrainingIndex] as ExerciseEntity,
        ),
      );
    });

    on<NextExercise>((event, emitter) async {
      _navigateToNext(emitter);
    });

    on<PreviousExercise>((event, emitter) async {
      _navigateToPrevious(emitter);
    });

    on<ExerciseDone>((event, emitter) async {
      //TODO: Implement below
      _chatService.sendClientNote();
      _exerciseService.markAsDone();
      _navigateToNext(emitter);
    });
  }

  void _navigateToPrevious(Emitter<TrainingState> emitter) {
    if (currentTrainingIndex > 0) {
      currentTrainingIndex--;
      if (_training[currentTrainingIndex] is BreakEntity) {
        _navigateToPrevious(emitter);
      } else {
        emitter(
          TrainingState.exerciseInProgress(
            _training[currentTrainingIndex] as ExerciseEntity,
          ),
        );
      }
    }
  }

  void _navigateToNext(Emitter<TrainingState> emitter) {
    if (currentTrainingIndex < _training.length - 1) {
      currentTrainingIndex++;
      if (_training[currentTrainingIndex] is BreakEntity) {
        emitter(
          TrainingState.trainingBreak(
            _training[currentTrainingIndex] as BreakEntity,
          ),
        );
      } else {
        emitter(
          TrainingState.exerciseInProgress(
            _training[currentTrainingIndex] as ExerciseEntity,
          ),
        );
      }
    } else {
      emitter(const TrainingState.finished());
    }
  }

  void _handleSuperset(
    List<String> supersetNames,
    String superset,
    List<ExerciseEntity> exercises,
    ExerciseEntity exerciseEntity,
    List<TrainingEntity> training,
  ) {
    supersetNames.add(superset);
    final supersetList = exercises
        .where(
          (element) =>
              element.exerciseOptionsData.supersetName ==
              exerciseEntity.exerciseOptionsData.supersetName,
        )
        .toList();

    final highestNumberOfSets = supersetList
        .map((superset) => superset.exerciseOptionsData.sets)
        .reduce((value, element) => value > element ? value : element);

    for (var index = 0; index < highestNumberOfSets; index++) {
      for (final superset in supersetList) {
        if (index < superset.exerciseOptionsData.sets) {
          training.add(superset);
        }
      }
      training.add(
        BreakEntity(
          breakTime: supersetList.first.exerciseOptionsData.timeBreak,
        ),
      );
    }
  }

  final List<TrainingEntity> _training = [];
  int currentTrainingIndex = 0;
  final _chatService = getIt.get<ChatService>();
  final _exerciseService = getIt.get<FirestoreExerciseService>();
}
