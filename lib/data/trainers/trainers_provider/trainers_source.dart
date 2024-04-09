import 'package:perso/core/models/trainer_entity.dart';
import 'package:perso/core/models/trainer_identity.dart';

abstract class TrainersSource {
  Future<List<TrainerEntity>> getAllTrainersData();

  Stream<TrainerEntity> getTrainers(String id);

  Future<List<String>> getSpecialities(String id);

  Future<List<TrainerIdentity>> getTrainersForClient(String clientId);

  Future<TrainerEntity> getTrainer(String id);
}
