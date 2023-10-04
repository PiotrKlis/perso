import 'package:Perso/app/models/editable_trainer_data.dart';
import 'package:Perso/core/models/trainer_entity.dart';

abstract class TrainersService {
  Future<void> updateData(EditableTrainerData trainerData);
  Future<void> setData(TrainerEntity trainerEntity);
}
