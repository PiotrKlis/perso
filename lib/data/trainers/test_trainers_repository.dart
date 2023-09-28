import 'package:Perso/app/models/trainer_card/review_entity.dart';
import 'package:Perso/app/models/trainer_card/trainer_entity.dart';
import 'package:Perso/data/trainers/trainers_source.dart';
import 'package:injectable/injectable.dart';

@injectable
class TestTrainersRepository implements TrainersSource {
  @override
  Future<List<TrainerEntity>> getTrainers() {
    return Future.value(_dummyTrainerCards);
  }

  final List<TrainerEntity> _dummyTrainerCards = [
    const TrainerEntity(
        id: '1',
        image: "assets/images/trainer3.png",
        name: "Son goku",
        surname: 'Surname',
        nickname: "@songoku",
        votesNumber: 13222,
        fullBio: 'Full bio',
        shortBio: 'Short bio',
        email: 'Email',
        languages: ['Polish', 'English'],
        location: 'Location',
        reviews: [ReviewEntity(rating: 3.2, description: "description")],
        categories: ['Training type 1', 'Training type 2'],
        rating: 5.0),
    const TrainerEntity(
        id: '2',
        image: "assets/images/trainer1.png",
        name: "Piccolo",
        surname: 'Surname',
        nickname: "@songoku",
        votesNumber: 13222,
        fullBio: 'Full bio',
        shortBio: 'Short bio',
        email: 'Email',
        languages: ['Polish', 'English'],
        location: 'Location',
        reviews: [ReviewEntity(rating: 3.2, description: "description")],
        categories: ['Training type 1', 'Training type 2'],
        rating: 2.5),
    const TrainerEntity(
        id: '3',
        image: "assets/images/trainer2.png",
        name: "Son gohan",
        surname: 'Surname',
        nickname: "@songoku",
        votesNumber: 13222,
        fullBio: 'Full bio',
        shortBio: 'Short bio',
        email: 'Email',
        languages: ['Polish', 'English'],
        location: 'Location',
        reviews: [ReviewEntity(rating: 3.2, description: "description")],
        categories: ['Training type 1', 'Training type 2'],
        rating: 4.5),
  ];
}
