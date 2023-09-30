import 'package:freezed_annotation/freezed_annotation.dart';
part 'trainer_details_event.freezed.dart';

@freezed
class TrainerDetailsEvent with _$TrainerDetailsEvent {
  const factory TrainerDetailsEvent.loadData() = LoadData;
  const factory TrainerDetailsEvent.addReview() = AddReview;
}
