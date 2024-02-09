import 'package:freezed_annotation/freezed_annotation.dart';
part 'trainer_identity.freezed.dart';

@freezed
class TrainerIdentity with _$TrainerIdentity {
  const factory TrainerIdentity({
    required String id,
    required String name,
    required String surname,
    required String nickname,
  }) = _TrainerIdentity;
}