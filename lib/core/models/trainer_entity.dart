import 'package:perso/core/models/review_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'trainer_entity.freezed.dart';

@freezed
class TrainerEntity with _$TrainerEntity {
  const factory TrainerEntity({
    required final String id,
    required final String name,
    required final String surname,
    required final String nickname,
    required final int votesNumber,
    required final String fullBio,
    required final String shortBio,
    required final String imagePath,
    required final List<String> languages,
    required final double rating,
    required final String location,
    required final List<ReviewEntity> reviews,
    required final List<String> categories,
    required final List<String> pendingRequests,
    required final List<String> activeClients,
    required final List<String> inactiveClients,
    required final LatLng latLng,
  }) = _TrainerEntity;
}
