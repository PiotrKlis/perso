import 'package:Perso/app/screens/trainer_details/event/trainer_details_event.dart';
import 'package:Perso/app/screens/trainer_details/state/trainer_details_state.dart';
import 'package:Perso/core/dependency_injection/get_it_config.dart';
import 'package:Perso/data/training_request/training_request_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TrainerDetailsBloc
    extends Bloc<TrainerDetailsEvent, TrainerDetailsState> {
  final TrainingRequestService _trainingRequestService =
      getIt.get<TrainingRequestService>();

  TrainerDetailsBloc() : super(const TrainerDetailsState.initial()) {
    on<LoadData>((event, emitter) async {});

    on<AddReview>((event, emitter) async {});

    on<TrainingRequest>((event, emitter) async {
      try {
        emitter(const TrainerDetailsState.loadingTrainingRequest());
        await _trainingRequestService.sendTrainingRequest(event.trainerEntity.id);
        emitter(const TrainerDetailsState.successTrainingRequest());
      } catch (error) {
       emitter(TrainerDetailsState.error(error.toString()));
      }
    });
  }
}
