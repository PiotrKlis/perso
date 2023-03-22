import 'package:Perso/app/models/trainer_card/trainer_card.dart';
import 'package:Perso/data/repositories/trainers/trainers_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class FirestoreTrainersRepository implements TrainersRepository {
  @override
  Future<List<TrainerCard>> getTrainerCards() {
    return Future.value();
  }
}
