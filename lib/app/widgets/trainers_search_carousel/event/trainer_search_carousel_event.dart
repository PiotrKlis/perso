import 'package:freezed_annotation/freezed_annotation.dart';
part 'trainer_search_carousel_event.freezed.dart';

@freezed
class TrainerSearchCarouselEvent with _$TrainerSearchCarouselEvent {
  const factory TrainerSearchCarouselEvent.loadData() = LoadData;
}
