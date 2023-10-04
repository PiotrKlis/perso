import 'package:Perso/app/screens/trainer_details/event/training_request_event.dart';
import 'package:Perso/app/screens/trainer_details/state/training_request_state.dart';
import 'package:Perso/core/dependency_injection/get_it_config.dart';
import 'package:Perso/data/training_request/training_request_service.dart';
import 'package:Perso/data/user_info/user_info_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TrainingRequestBloc
    extends Bloc<TrainingRequestEvent, TrainingRequestState> {
  final TrainingRequestService _trainingRequestService =
      getIt.get<TrainingRequestService>();
  final UserInfoProvider _userInfoProvider = getIt.get<UserInfoProvider>();

  TrainingRequestBloc(TrainingRequestState trainingRequestState)
      : super(trainingRequestState) {
    on<TrainingRequest>((event, emitter) async {
      try {
        bool isUserLoggedIn = await _userInfoProvider.isUserLoggedIn();
        if (isUserLoggedIn) {
          emitter(const TrainingRequestState.loadingTrainingRequest());
          await _trainingRequestService.sendTrainingRequest(event.trainerId);
          emitter(const TrainingRequestState.successTrainingRequest());
        } else {
          emitter(const TrainingRequestState.navigateToSignUp());
          emitter(const TrainingRequestState.initial());
        }
      } catch (error) {
        //TODO: Add error handling
        emitter(const TrainingRequestState.initial());
      }
    });

    on<CheckIfUserHasAlreadyRequestTraining>((event, emitter) async {
      try {
        final bool hasAlreadySentRequest = await _trainingRequestService
            .checkIfUserHasAlreadySentRequest(event.trainerId);
        emitter(TrainingRequestState.hasUserAlreadyRequestedTraining(
            hasAlreadySentRequest));
      } catch (error) {
        emitter(const TrainingRequestState.initial());
      }
    });
  }
}
