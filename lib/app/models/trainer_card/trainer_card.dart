import 'package:freezed_annotation/freezed_annotation.dart';

part 'trainer_card.freezed.dart';

@freezed
class TrainerCard with _$TrainerCard {
  const factory TrainerCard({
    required String icon,
    required String name,
    required String nickname,
    required String description,
    required double ratingScore,
    required int votesNumber,
  }) = _TrainerCard;
}
