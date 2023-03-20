import 'package:Perso/app/models/trainers_search_card_data/trainers_search_carousel_card_data.dart';
import 'package:Perso/app/widgets/trainers_search_carousel/event/trainer_search_carousel_event.dart';
import 'package:Perso/app/widgets/trainers_search_carousel/state/trainer_search_carousel_state.dart';
import 'package:Perso/data/repositories/trainer_search_cards/local_trainer_search_card_repository.dart';
import 'package:Perso/data/repositories/trainer_search_cards/trainer_search_card_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class TrainerSearchCarouselBloc
    extends Bloc<TrainerSearchCarouselEvent, TrainerSearchCarouselState> {
  final TrainerSearchCardRepository _repository =
      GetIt.I.get<LocalTrainerSearchCardRepository>();

  TrainerSearchCarouselBloc(TrainerSearchCarouselState initialState)
      : super(initialState) {
    on<LoadData>((event, emitter) async {
      try {
        List<TrainersSearchCarouselCardData> cardsData =
            await _repository.getAllCards();
        emitter(TrainerSearchCarouselState.content(cardsData: cardsData));
      } catch (error) {
        emitter(TrainerSearchCarouselState.error(error: error.toString()));
      }
    });
  }
}
