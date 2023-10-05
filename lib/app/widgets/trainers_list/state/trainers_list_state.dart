import 'package:Perso/core/models/trainer_short_data.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'trainers_list_state.freezed.dart';

@freezed
class TrainersListState with _$TrainersListState {
  const factory TrainersListState.initial() = Initial;

  const factory TrainersListState.content(
      {required List<TrainerShortData> trainers}) = Content;

  const factory TrainersListState.error({required String error}) = Error;
}
