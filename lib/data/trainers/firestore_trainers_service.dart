import 'package:Perso/data/trainers/trainers_service.dart';
import 'package:injectable/injectable.dart';

@injectable
class FirestoreTrainersService implements TrainersService {
  @override
  Future<void> manageData() {
    //TODO: Send data to firestore
    return Future.value();
  }

}