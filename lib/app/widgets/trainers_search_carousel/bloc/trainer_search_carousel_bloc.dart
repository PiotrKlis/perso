import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perso/app/widgets/trainers_search_carousel/event/trainer_search_carousel_event.dart';
import 'package:perso/app/widgets/trainers_search_carousel/state/trainer_search_carousel_state.dart';
import 'package:perso/core/dependency_injection/get_it.dart';
import 'package:perso/data/trainer_search_cards/local_trainer_search_card_repository.dart';
import 'package:perso/data/trainer_search_cards/trainer_search_card_source.dart';

class TrainerSearchCarouselBloc
    extends Bloc<TrainerSearchCarouselEvent, TrainerSearchCarouselState> {

  TrainerSearchCarouselBloc(super.initialState) {
    on<LoadData>((event, emitter) async {
      try {
        final cardsData =
            await _repository.getAllCards();
        emitter(TrainerSearchCarouselState.content(cardsData: cardsData));
      } catch (error) {
        emitter(TrainerSearchCarouselState.error(error: error.toString()));
      }
    });
  }
  final TrainerSearchCardSource _repository =
      getIt.get<LocalTrainerSearchCardRepository>();
}
