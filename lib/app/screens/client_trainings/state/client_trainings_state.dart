import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:perso/core/models/trainer_identity.dart';

part 'client_trainings_state.freezed.dart';

@freezed
class ClientTrainingState with _$ClientTrainingState {
  const factory ClientTrainingState.initial() = Initial;

  const factory ClientTrainingState.loading() = Loading;

  const factory ClientTrainingState.trainings({
    required List<TrainerIdentity> trainerIdentities,
  }) = Trainings;

  const factory ClientTrainingState.error(String error) = Error;
}
