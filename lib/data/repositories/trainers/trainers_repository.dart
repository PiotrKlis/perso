import 'package:Perso/app/models/trainer_card/trainer_card.dart';

abstract class TrainersRepository {
  Future<List<TrainerCard>> getTrainerCards();
}