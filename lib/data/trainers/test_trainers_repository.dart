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
    TrainerEntity(
        id: '1',
        icon: "assets/images/trainer3.png",
        name: "Son goku",
        surname: 'Surname',
        nickname: "@songoku",
        votesNumber: 13222,
        fullBio: 'Full bio',
        shortBio: 'Short bio',
        email: 'Email',
        languages: ['Polish', 'English'],
        location: 'Location',
        phoneNumber: 'Phone number',
        reviews: [ReviewEntity(rating: 3.2, description: "description")],
        trainingTypes: ['Training type 1', 'Training type 2'],
        rating: 5.0),
    TrainerEntity(
        id: '2',
        icon: "assets/images/trainer1.png",
        name: "Piccolo",
        surname: 'Surname',
        nickname: "@songoku",
        votesNumber: 13222,
        fullBio: 'Full bio',
        shortBio: 'Short bio',
        email: 'Email',
        languages: ['Polish', 'English'],
        location: 'Location',
        phoneNumber: 'Phone number',
        reviews: [ReviewEntity(rating: 3.2, description: "description")],
        trainingTypes: ['Training type 1', 'Training type 2'],
        rating: 2.5),
    TrainerEntity(
        id: '3',
        icon: "assets/images/trainer2.png",
        name: "Son gohan",
        surname: 'Surname',
        nickname: "@songoku",
        votesNumber: 13222,
        fullBio: 'Full bio',
        shortBio: 'Short bio',
        email: 'Email',
        languages: ['Polish', 'English'],
        location: 'Location',
        phoneNumber: 'Phone number',
        reviews: [ReviewEntity(rating: 3.2, description: "description")],
        trainingTypes: ['Training type 1', 'Training type 2'],
        rating: 4.5),
  ];
}
