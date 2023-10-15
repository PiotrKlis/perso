import 'package:Perso/core/models/trainer_entity.dart';

abstract class TrainersSource {
  Future<List<TrainerEntity>> getAllTrainersData();

  Future<TrainerEntity> getTrainerData(String id);

  Future<List<String>> getSpecialities(String id);
}
