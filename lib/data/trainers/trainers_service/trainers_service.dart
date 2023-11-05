import 'package:perso/app/models/editable_trainer_data.dart';
import 'package:perso/core/models/trainer_entity.dart';

abstract class TrainersService {
  Future<void> updateData(EditableTrainerData trainerData);

  Future<void> uploadFullTrainerData(TrainerEntity trainerEntity);

  Future<void> activateClient(String clientId);

  Future<void> deactivateClient(String clientId);

  Future<void> removeClient(String clientId);
}
