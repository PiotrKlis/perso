import 'package:Perso/app/models/trainer_card/trainer_card.dart';

abstract class TrainerCardRepository {
  Future<List<TrainerCard>> getTrainerCards();
}