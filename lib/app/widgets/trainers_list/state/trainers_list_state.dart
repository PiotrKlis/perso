import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:perso/core/models/trainer_entity.dart';

part 'trainers_list_state.freezed.dart';

@freezed
class TrainersListState with _$TrainersListState {
  const factory TrainersListState.initial() = Initial;

  const factory TrainersListState.loading() = Loading;

  const factory TrainersListState.content(
      {required List<TrainerEntity> trainers,}) = Content;

  const factory TrainersListState.error({required String error}) = Error;
}
