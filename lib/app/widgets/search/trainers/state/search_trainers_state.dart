import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:perso/core/models/exercise_entity.dart';
import 'package:perso/core/models/trainer_entity.dart';

part 'search_trainers_state.freezed.dart';

@freezed
class SearchTrainersState with _$SearchTrainersState {
  const factory SearchTrainersState.exercises(List<TrainerEntity> trainers) =
      Exercises;

  const factory SearchTrainersState.empty() = Empty;
  const factory SearchTrainersState.error(String error) = Error;
  const factory SearchTrainersState.loading() = Loading;
}
