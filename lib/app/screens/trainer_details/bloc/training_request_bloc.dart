import 'package:perso/app/screens/trainer_details/event/training_request_event.dart';
import 'package:perso/app/screens/trainer_details/state/training_request_state.dart';
import 'package:perso/core/dependency_injection/get_it.dart';
import 'package:perso/data/training_request/training_request_service.dart';
import 'package:perso/data/user_info/user_info_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TrainingRequestBloc
    extends Bloc<TrainingRequestEvent, TrainingRequestState> {

  TrainingRequestBloc(super.trainingRequestState) {
    on<TrainingRequest>((event, emitter) async {
      try {
        final isUserLoggedIn = await _userInfoProvider.isUserLoggedIn();
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
        final hasAlreadySentRequest = await _trainingRequestService
            .checkIfUserHasAlreadySentRequest(event.trainerId);
        emitter(TrainingRequestState.hasUserAlreadyRequestedTraining(
            hasAlreadySentRequest,),);
      } catch (error) {
        emitter(const TrainingRequestState.initial());
      }
    });
  }
  final TrainingRequestService _trainingRequestService =
      getIt.get<TrainingRequestService>();
  final UserInfoProvider _userInfoProvider = getIt.get<UserInfoProvider>();
}
