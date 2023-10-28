import 'package:freezed_annotation/freezed_annotation.dart';
part 'trainer_client_list_event.freezed.dart';

@freezed
class TrainerClientsListEvent with _$TrainerClientsListEvent {
  const factory TrainerClientsListEvent.loadData() = LoadData;
}
