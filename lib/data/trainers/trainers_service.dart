import 'package:Perso/app/models/trainer_data.dart';

abstract class TrainersService {
  Future<void> uploadData(TrainerData trainerData);
}