import 'package:freezed_annotation/freezed_annotation.dart';

part 'trainers_search_carousel_card_data.freezed.dart';

@freezed
class TrainersSearchCarouselCardData with _$TrainersSearchCarouselCardData {
  const factory TrainersSearchCarouselCardData(
      {required String image,
      required String categoryName,
      required String title,
      required String subtitle,}) = _TrainersSearchCarouselCardData;
}
