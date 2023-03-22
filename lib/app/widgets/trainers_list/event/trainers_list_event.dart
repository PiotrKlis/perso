import 'package:freezed_annotation/freezed_annotation.dart';
part 'trainers_list_event.freezed.dart';

@freezed
class TrainersListEvent with _$TrainersListEvent {
  const factory TrainersListEvent.loadData() = LoadData;
}
