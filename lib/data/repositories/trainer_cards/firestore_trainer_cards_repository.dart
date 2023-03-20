import 'package:Perso/app/models/trainer_card/trainer_card.dart';
import 'package:Perso/data/repositories/trainer_cards/trainer_card_repository.dart';

class FirestoreTrainerCardRepository implements TrainerCardRepository {
  @override
  Future<List<TrainerCard>> getTrainerCards() {
    return Future.value();
  }
}
