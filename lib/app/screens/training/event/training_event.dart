import 'package:freezed_annotation/freezed_annotation.dart';
part 'training_event.freezed.dart';

@freezed
class TrainingEvent with _$TrainingEvent {
  const factory TrainingEvent.loadTraining() = LoadTraining;
  const factory TrainingEvent.nextExercise() = NextExercise;
  const factory TrainingEvent.previousExercise() = PreviousExercise;
  const factory TrainingEvent.stop() = Stop;
  const factory TrainingEvent.start() = Start;
}
