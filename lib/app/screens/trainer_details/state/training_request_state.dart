import 'package:freezed_annotation/freezed_annotation.dart';

part 'training_request_state.freezed.dart';

@freezed
class TrainingRequestState with _$TrainingRequestState {
  const factory TrainingRequestState.initial() = Initial;

  const factory TrainingRequestState.hasUserAlreadyRequestedTraining(
      bool hasRequested) = HasUserAlreadyRequestedTraining;

  const factory TrainingRequestState.loadingTrainingRequest() =
      LoadingTrainingRequest;

  const factory TrainingRequestState.successTrainingRequest() =
      SuccessTrainingRequest;

  const factory TrainingRequestState.navigateToSignUp() = NavigateToSignUp;
}
