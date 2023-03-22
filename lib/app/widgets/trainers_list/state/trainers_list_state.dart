import 'package:Perso/app/models/trainer_card/trainer_card.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'trainers_list_state.freezed.dart';

@freezed
class TrainersListState with _$TrainersListState {
  const factory TrainersListState.initial() = Initial;

  const factory TrainersListState.content(
      {required List<TrainerCard> trainers}) = Content;

  const factory TrainersListState.error({required String error}) = Error;
}
