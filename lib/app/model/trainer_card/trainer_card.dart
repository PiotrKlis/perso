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

List<TrainerCard> dummyTrainerCards = [
  TrainerCard(
      icon: "assets/images/trainer3.png",
      name: "Fitness świr",
      nickname: "@fitnessSwir",
      description: "Najwiekszy fitnes swir na swiecie. Najwiekszy fitnes swir na swiecie. Najwiekszy fitnes swir na swiecie.",
      ratingScore: 4.6,
      votesNumber: 142),
  TrainerCard(
      icon: "assets/images/trainer2.png",
      name: "Muskules",
      nickname: "@muskules",
      description: "Herkules? A może i Muskules",
      ratingScore: 4.2,
      votesNumber: 13),
  TrainerCard(
      icon: "assets/images/trainer1.png",
      name: "Trener",
      nickname: "@trener",
      description: "Po prostu trener",
      ratingScore: 3.2,
      votesNumber: 1425),
  TrainerCard(
      icon: "assets/images/trainer1.png",
      name: "Pani trener",
      nickname: "@panitrener",
      description: "Pani trener zaprasza wszystkie panie na trening. Pani trener zaprasza wszystkie panie na trening",
      ratingScore: 2.9,
      votesNumber: 12),
  TrainerCard(
      icon: "assets/images/trainer2.png",
      name: "Beznadziejny trener",
      nickname: "@beznadziejny",
      description: "Najgorszy trener w calej stawce",
      ratingScore: 1.0,
      votesNumber: 1),
  TrainerCard(
      icon: "assets/images/trainer3.png",
      name: "Son goku",
      nickname: "@songoku",
      description: "Chcesz nauczyć się kamehameha? Wpadnij na trening",
      ratingScore: 5.0,
      votesNumber: 13222),
];
