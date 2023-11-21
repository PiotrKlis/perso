import 'package:freezed_annotation/freezed_annotation.dart';
part 'training_request_event.freezed.dart';

@freezed
class TrainingRequestEvent with _$TrainingRequestEvent {
  const factory TrainingRequestEvent.trainingRequest(String trainerId) =
      TrainingRequest;
  const factory TrainingRequestEvent.checkIfUserHasAlreadyRequestTraining(
      String trainerId,) = CheckIfUserHasAlreadyRequestTraining;
}
