import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perso/app/screens/training/event/training_event.dart';
import 'package:perso/app/screens/training/state/training_state.dart';
import 'package:perso/core/models/exercise_entity.dart';

class TrainingBloc extends Bloc<TrainingEvent, TrainingState> {
  TrainingBloc() : super(const TrainingState.initial()) {
    on<LoadTraining>((event, emitter) async {
      _exercises = event.exercises;
      emitter(
        TrainingState.exerciseInProgress(_exercises[currentExerciseIndex]),
      );
    });
    on<NextExercise>((event, emitter) async {
      if (currentExerciseIndex < _exercises.length - 1) {
        currentExerciseIndex++;
        emitter(
          TrainingState.exerciseInProgress(_exercises[currentExerciseIndex]),
        );
      }
    });
    on<PreviousExercise>((event, emitter) async {
      if (currentExerciseIndex > 0) {
        currentExerciseIndex--;
        emitter(
          TrainingState.exerciseInProgress(_exercises[currentExerciseIndex]),
        );
      }
    });
    // on<Stop>((event, emitter) async {});
    // on<Start>((event, emitter) async {});
  }

  List<ExerciseEntity> _exercises = [];
  int currentExerciseIndex = 0;


}
