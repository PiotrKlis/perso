import 'package:freezed_annotation/freezed_annotation.dart';
part 'client_trainings_event.freezed.dart';

@freezed
class ClientTrainingEvent with _$ClientTrainingEvent {
  const factory ClientTrainingEvent.loadTrainings() = LoadTrainings;
}
