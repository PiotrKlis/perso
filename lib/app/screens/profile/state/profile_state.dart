import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:perso/core/models/profile_entity.dart';
import 'package:perso/core/models/trainer_entity.dart';
part 'profile_state.freezed.dart';

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState.initial() = Initial;
  const factory ProfileState.data(ProfileEntity profileEntity) = Data;
}
