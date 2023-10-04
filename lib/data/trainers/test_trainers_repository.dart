import 'package:Perso/core/models/trainer_entity.dart';
import 'package:Perso/core/models/trainer_short_data.dart';
import 'package:Perso/data/trainers/trainers_source.dart';
import 'package:injectable/injectable.dart';

@injectable
class TestTrainersRepository implements TrainersSource {
  @override
  Future<List<TrainerShortData>> getAllTrainersShortData() {
    return Future.value(_dummyTrainerCards);
  }

  final List<TrainerShortData> _dummyTrainerCards = [
    const TrainerShortData(
        id: '1',
        name: "Son goku",
        surname: 'Surname',
        nickname: "@songoku",
        votesNumber: 13222,
        rating: 4.5,
        categories: ['Training type 1', 'Training type 2'],
        languages: ['Polish', 'English'],
        shortBio: "shortBio",
        imagePath: ""),
    const TrainerShortData(
        id: '2',
        name: "Son gohan",
        surname: 'Surnamenos',
        nickname: "@songohan",
        votesNumber: 13222,
        rating: 4.5,
        categories: ['Training type 1', 'Training type 2'],
        languages: ['Polish', 'English'],
        shortBio: "shortBio",
        imagePath: ""),
    const TrainerShortData(
        id: '1',
        name: "Son goten",
        surname: 'Surnamini',
        nickname: "@songoten",
        votesNumber: 13222,
        rating: 4.5,
        categories: ['Training type 1', 'Training type 2'],
        languages: ['Polish', 'English'],
        shortBio: "shortBio",
        imagePath: "")
  ];

  @override
  Future<TrainerEntity> getTrainerData(String id) {
    // TODO: implement getTrainerData
    throw UnimplementedError();
  }
}
