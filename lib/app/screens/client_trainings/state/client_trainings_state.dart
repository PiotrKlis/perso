import 'package:freezed_annotation/freezed_annotation.dart';
part 'client_trainings_state.freezed.dart';

@freezed
class ClientTrainingState with _$ClientTrainingState {
  const factory ClientTrainingState.initial() = Initial;
}
