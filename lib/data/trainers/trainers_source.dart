import 'package:Perso/core/models/trainer_entity.dart';
import 'package:Perso/core/models/trainer_short_data.dart';

abstract class TrainersSource {
  Future<List<TrainerShortData>> getAllTrainersShortData();
  Future<TrainerEntity> getTrainerData(String id);
}