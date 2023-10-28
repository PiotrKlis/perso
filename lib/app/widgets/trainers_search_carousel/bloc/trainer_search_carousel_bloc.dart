import 'package:perso/app/models/trainers_search_card_data/trainers_search_carousel_card_data.dart';
import 'package:perso/app/widgets/trainers_search_carousel/event/trainer_search_carousel_event.dart';
import 'package:perso/app/widgets/trainers_search_carousel/state/trainer_search_carousel_state.dart';
import 'package:perso/core/dependency_injection/get_it.dart';
import 'package:perso/data/trainer_search_cards/local_trainer_search_card_repository.dart';
import 'package:perso/data/trainer_search_cards/trainer_search_card_source.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TrainerSearchCarouselBloc
    extends Bloc<TrainerSearchCarouselEvent, TrainerSearchCarouselState> {
  final TrainerSearchCardSource _repository =
      getIt.get<LocalTrainerSearchCardRepository>();

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
