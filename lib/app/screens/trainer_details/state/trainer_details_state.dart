import 'package:freezed_annotation/freezed_annotation.dart';
part 'trainer_details_state.freezed.dart';

@freezed
class TrainerDetailsState with _$TrainerDetailsState {
  const factory TrainerDetailsState.initial() = Initial;
  const factory TrainerDetailsState.content() = Content;
  const factory TrainerDetailsState.error() = Error;
}
