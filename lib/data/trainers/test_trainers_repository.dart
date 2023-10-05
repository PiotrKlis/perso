import 'package:Perso/core/models/trainer_entity.dart';
import 'package:Perso/data/trainers/trainers_source.dart';
import 'package:injectable/injectable.dart';

@injectable
class TestTrainersRepository implements TrainersSource {
  @override
  Future<List<TrainerEntity>> getAllTrainersData() {
    return Future.value(_dummyTrainerCards);
  }

  final List<TrainerEntity> _dummyTrainerCards = [
    const TrainerEntity(
        id: '1',
        name: "Son goku",
        surname: 'Surname',
        nickname: "@songoku",
        votesNumber: 13222,
        rating: 4.5,
        categories: ['Training type 1', 'Training type 2'],
        languages: ['Polish', 'English'],
        shortBio: "shortBio",
        imagePath: "",
        fullBio: "fullBio",
        location: "location",
        reviews: [],
        pendingRequests: [],
        activeClients: [],
        inactiveClients: []),
    const TrainerEntity(
        id: '2',
        name: "Son gohan",
        surname: 'Surname',
        nickname: "@songohan",
        votesNumber: 13222,
        rating: 4.5,
        categories: ['Training type 1', 'Training type 2'],
        languages: ['Polish', 'English'],
        shortBio: "shortBio",
        imagePath: "",
        fullBio: "fullBio",
        location: "location",
        reviews: [],
        pendingRequests: [],
        activeClients: [],
        inactiveClients: []),
    const TrainerEntity(
        id: '3',
        name: "Son goten",
        surname: 'Surname',
        nickname: "@songoten",
        votesNumber: 13222,
        rating: 4.5,
        categories: ['Training type 1', 'Training type 2'],
        languages: ['Polish', 'English'],
        shortBio: "shortBio",
        imagePath: "",
        fullBio: "fullBio",
        location: "location",
        reviews: [],
        pendingRequests: [],
        activeClients: [],
        inactiveClients: []),
  ];

  @override
  Future<TrainerEntity> getTrainerData(String id) {
    return Future.value(_dummyTrainerCards.first);
  }

  @override
  Future<List<String>> getSpecialities(String id) {
    return Future.value(List.empty());
  }
}
