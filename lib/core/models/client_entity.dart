import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:perso/core/models/profile_entity.dart';

part 'client_entity.freezed.dart';

@freezed
class ClientEntity extends ProfileEntity with _$ClientEntity {
  const factory ClientEntity({
    required String id,
    required String name,
    required String surname,
    required String nickname,
    required String imagePath,
    required List<String> pendingTrainers,
    required List<String> activeTrainers,
    required List<String> inactiveTrainers,
  }) = _ClientEntity;
}
