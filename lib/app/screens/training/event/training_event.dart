import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:perso/core/models/exercise_entity.dart';

part 'training_event.freezed.dart';

@freezed
class TrainingEvent with _$TrainingEvent {
  const factory TrainingEvent.loadTraining(List<ExerciseEntity> exercises) =
      LoadTraining;

  const factory TrainingEvent.nextExercise() = NextExercise;

  const factory TrainingEvent.exerciseDone() = ExerciseDone;

  const factory TrainingEvent.previousExercise() = PreviousExercise;

  const factory TrainingEvent.stop() = Stop;

  const factory TrainingEvent.start() = Start;
}
