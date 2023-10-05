import 'package:freezed_annotation/freezed_annotation.dart';
part 'trainer_details_event.freezed.dart';

@freezed
class TrainerDetailsEvent with _$TrainerDetailsEvent {
  const factory TrainerDetailsEvent.loadData(String trainerId) = LoadData;
  const factory TrainerDetailsEvent.addReview() = AddReview;
  const factory TrainerDetailsEvent.trainingRequest(String trainerId) = TrainingRequest;
}
