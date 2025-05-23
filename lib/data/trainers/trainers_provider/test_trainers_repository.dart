import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:perso/core/models/trainer_entity.dart';
import 'package:perso/core/models/trainer_identity.dart';
import 'package:perso/core/models/user_type.dart';
import 'package:perso/data/trainers/trainers_provider/trainers_source.dart';

@injectable
class TestTrainersRepository implements TrainersSource {
  @override
  Future<List<TrainerEntity>> getAllTrainersData() {
    return Future.value(_dummyTrainerCards);
  }

  final List<TrainerEntity> _dummyTrainerCards = [
    const TrainerEntity(
      id: '1',
      name: 'Son goku',
      surname: 'Surname',
      nickname: '@songoku',
      votesNumber: 13222,
      rating: 4.5,
      categories: ['Training type 1', 'Training type 2'],
      languages: ['Polish', 'English'],
      shortBio: 'shortBio',
      imagePath: '',
      longBio: 'fullBio',
      address: 'location',
      reviews: [],
      pendingClients: [],
      activeClients: [],
      inactiveClients: [],
      latLng: LatLng(0, 0),
      userType: UserType.trainer,
    ),
    const TrainerEntity(
      id: '2',
      name: 'Son gohan',
      surname: 'Surname',
      nickname: '@songohan',
      votesNumber: 13222,
      rating: 4.5,
      categories: ['Training type 1', 'Training type 2'],
      languages: ['Polish', 'English'],
      shortBio: 'shortBio',
      imagePath: '',
      longBio: 'fullBio',
      address: 'location',
      reviews: [],
      pendingClients: [],
      activeClients: [],
      inactiveClients: [],
      latLng: LatLng(0, 0),
      userType: UserType.trainer,
    ),
    const TrainerEntity(
      id: '3',
      name: 'Son goten',
      surname: 'Surname',
      nickname: '@songoten',
      votesNumber: 13222,
      rating: 4.5,
      categories: ['Training type 1', 'Training type 2'],
      languages: ['Polish', 'English'],
      shortBio: 'shortBio',
      imagePath: '',
      longBio: 'fullBio',
      address: 'location',
      reviews: [],
      pendingClients: [],
      activeClients: [],
      inactiveClients: [],
      latLng: LatLng(0, 0),
      userType: UserType.trainer,
    ),
  ];

  @override
  Stream<TrainerEntity> getTrainers(String id) async* {
    yield const TrainerEntity(
      id: '1',
      name: 'Son goku',
      surname: 'Surname',
      nickname: '@songoku',
      votesNumber: 13222,
      rating: 4.5,
      categories: ['Training type 1', 'Training type 2'],
      languages: ['Polish', 'English'],
      shortBio: 'shortBio',
      imagePath: '',
      longBio: 'fullBio',
      address: 'location',
      reviews: [],
      pendingClients: [],
      activeClients: [],
      inactiveClients: [],
      latLng: LatLng(0, 0),
      userType: UserType.trainer,
    );
  }

  @override
  Future<List<String>> getSpecialities(String id) {
    return Future.value(List.empty());
  }

  @override
  Future<void> activateClient(String clientId, String trainerId) {
    return Future.value();
  }

  @override
  Future<void> deactivateClient(String clientId, String trainerId) {
    return Future.value();
  }

  @override
  Future<void> removeClient(String clientId, String trainerId) {
    return Future.value();
  }

  @override
  Future<List<TrainerIdentity>> getTrainersForClient(String clientId) {
    // TODO: implement getTrainersForClient
    throw UnimplementedError();
  }

  @override
  Future<TrainerEntity> getTrainer(String id) {
    // TODO: implement getTrainer
    throw UnimplementedError();
  }
}
