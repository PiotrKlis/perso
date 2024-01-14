import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:perso/app/models/trainers_search_card_data/trainers_search_carousel_card_data.dart';

part 'trainer_search_carousel_state.freezed.dart';

@freezed
class TrainerSearchCarouselState with _$TrainerSearchCarouselState {
  const factory TrainerSearchCarouselState.initial() = Initial;
  const factory TrainerSearchCarouselState.content(
      {required List<TrainersSearchCarouselCardData> cardsData,}) = Content;
  const factory TrainerSearchCarouselState.error({required String error}) =
      Error;
}
