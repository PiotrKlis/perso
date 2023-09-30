import 'package:Perso/app/screens/trainer_details/event/trainer_details_event.dart';
import 'package:Perso/app/screens/trainer_details/state/trainer_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TrainerDetailsBloc
    extends Bloc<TrainerDetailsEvent, TrainerDetailsState> {
  // final RegisterProvider registerProvider = getIt.get<RegisterProvider>();

  TrainerDetailsBloc() : super(const TrainerDetailsState.initial()) {
    on<LoadData>((event, emitter) async {

    });

    on<AddReview>((event, emitter) async {

    });
  }
}
