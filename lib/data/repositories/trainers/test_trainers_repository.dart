import 'package:Perso/app/models/trainer_card/trainer_card.dart';
import 'package:Perso/data/repositories/trainers/trainers_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class TestTrainersRepository implements TrainersRepository {
  @override
  Future<List<TrainerCard>> getTrainerCards() {
    return Future.value(_dummyTrainerCards);
  }

  final List<TrainerCard> _dummyTrainerCards = [
    const TrainerCard(
        icon: "assets/images/trainer3.png",
        name: "Fitness świr",
        nickname: "@fitnessSwir",
        description:
            "Najwiekszy fitnes swir na swiecie. Najwiekszy fitnes swir na swiecie. Najwiekszy fitnes swir na swiecie.",
        ratingScore: 4.6,
        votesNumber: 142),
    const TrainerCard(
        icon: "assets/images/trainer2.png",
        name: "Muskules",
        nickname: "@muskules",
        description: "Herkules? A może i Muskules",
        ratingScore: 4.2,
        votesNumber: 13),
    const TrainerCard(
        icon: "assets/images/trainer1.png",
        name: "Trener",
        nickname: "@trener",
        description: "Po prostu trener",
        ratingScore: 3.2,
        votesNumber: 1425),
    const TrainerCard(
        icon: "assets/images/trainer1.png",
        name: "Pani trener",
        nickname: "@panitrener",
        description:
            "Pani trener zaprasza wszystkie panie na trening. Pani trener zaprasza wszystkie panie na trening",
        ratingScore: 2.9,
        votesNumber: 12),
    const TrainerCard(
        icon: "assets/images/trainer2.png",
        name: "Beznadziejny trener",
        nickname: "@beznadziejny",
        description: "Najgorszy trener w calej stawce",
        ratingScore: 1.0,
        votesNumber: 1),
    const TrainerCard(
        icon: "assets/images/trainer3.png",
        name: "Son goku",
        nickname: "@songoku",
        description: "Chcesz nauczyć się kamehameha? Wpadnij na trening",
        ratingScore: 5.0,
        votesNumber: 13222),
  ];
}
