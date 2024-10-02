import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:perso/core/models/profile_entity.dart';
import 'package:perso/core/models/review_entity.dart';

part 'trainer_entity.freezed.dart';

@freezed
class TrainerEntity extends ProfileEntity with _$TrainerEntity {
  const factory TrainerEntity({
    required String id,
    required String name,
    required String surname,
    required String nickname,
    required int votesNumber,
    required String fullBio,
    required String shortBio,
    required String imagePath,
    required List<String> languages,
    required double rating,
    required String address,
    required List<ReviewEntity> reviews,
    required List<String> categories,
    required List<String> pendingClients,
    required List<String> activeClients,
    required List<String> inactiveClients,
    required LatLng latLng,
  }) = _TrainerEntity;
}
