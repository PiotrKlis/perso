import 'package:freezed_annotation/freezed_annotation.dart';
part 'client_trainings_event.freezed.dart';

@freezed
class EmptyEvent with _$EmptyEvent {
  const factory EmptyEvent.loadData() = LoadData;
}
