import 'package:Perso/core/models/trainer_entity.dart';
import 'package:Perso/core/user_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'trainer_details_state.freezed.dart';

@freezed
class TrainerDetailsState with _$TrainerDetailsState {
  const factory TrainerDetailsState.initial() = Initial;

  const factory TrainerDetailsState.content(
      TrainerEntity trainerEntity, UserType? userType) = Content;

  const factory TrainerDetailsState.error(String error) = Error;
}
