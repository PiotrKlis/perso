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
      final exercises = event.exercises;
      for (final currentExercise in exercises) {
        final numberOfSets = currentExercise.exerciseOptionsData.sets;
        final supersetName = currentExercise.exerciseOptionsData.supersetName;
        final shouldAddSuperset =
            supersetName.isNotEmpty && !addedSupersets.contains(supersetName);
        if (shouldAddSuperset) {
          _handleSuperset(
            addedSupersets,
            supersetName,
            event.exercises,
          );
          break;
        }
        for (var index = 0; index < numberOfSets; index++) {
          //TODO: add new class - ExerciseSetEntity with currentSet
          _training.add(currentExercise);
          final nextExerciseTitle = _getNextExerciseTitle(
            index,
            currentExercise,
            exercises,
          );
          _training.add(
            BreakEntity(
              breakTime: currentExercise.exerciseOptionsData.timeBreak,
              nextExerciseTitle: nextExerciseTitle,
            ),
          );
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

  String _getNextExerciseTitle(
    int index,
    ExerciseEntity exerciseEntity,
    List<ExerciseEntity> exercises,
  ) {
    final isNextExerciseFromTheSameSet =
        index < exerciseEntity.exerciseOptionsData.sets - 1;
    if (isNextExerciseFromTheSameSet) {
      return exerciseEntity.title;
    } else {
      final isLastExercise =
          exercises.indexOf(exerciseEntity) == exercises.length - 1;
      if (isLastExercise) {
        return '';
      } else {
        return exercises[exercises.indexOf(exerciseEntity) + 1].title;
      }
    }
  }

  void _handleSuperset(
    List<String> addedSupersets,
    String supersetName,
    List<ExerciseEntity> exercises,
  ) {
    addedSupersets.add(supersetName);
    final supersetList = exercises
        .where(
          (element) => element.exerciseOptionsData.supersetName == supersetName,
        )
        .toList();

    final highestNumberOfSets = supersetList
        .map((superset) => superset.exerciseOptionsData.sets)
        .reduce((value, element) => value > element ? value : element);

    for (var index = 0; index < highestNumberOfSets; index++) {
      for (final exercise in supersetList) {
        if (index < exercise.exerciseOptionsData.sets) {
          _training.add(exercise);
        }
      }
      _training.add(
        BreakEntity(
          breakTime: supersetList.first.exerciseOptionsData.timeBreak,
          nextExerciseTitle: 'Next superset round',
        ),
      );
    }
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

  final List<TrainingEntity> _training = [];
  int currentTrainingIndex = 0;
  final _chatService = getIt.get<ChatService>();
  final _exerciseService = getIt.get<FirestoreExerciseService>();
}
