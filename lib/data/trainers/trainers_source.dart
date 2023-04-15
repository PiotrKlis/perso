import 'package:Perso/app/models/trainer_card/trainer_entity.dart';

abstract class TrainersSource {
  Future<List<TrainerEntity>> getTrainers();
}