import 'package:perso/core/models/trainer_entity.dart';

abstract class TrainersSource {
  Future<List<TrainerEntity>> getAllTrainersData();

  Stream<TrainerEntity> getTrainerData(String id);

  Future<List<String>> getSpecialities(String id);
}
