import 'package:Perso/app/models/trainer_card/trainer_entity.dart';
import 'package:Perso/app/models/trainer_data.dart';

abstract class TrainersService {
  Future<void> updateData(TrainerData trainerData);
  Future<void> setData(TrainerEntity trainerEntity);
}