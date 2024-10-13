import 'package:perso/app/models/trainers_search_card_data/trainers_search_carousel_card_data.dart';

mixin TrainerSearchCardSource {
  Future<List<TrainersSearchCarouselCardData>> getAllCards();
}
