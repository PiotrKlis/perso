import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:perso/core/models/trainer_entity.dart';

part 'map_data.freezed.dart';

@freezed
class MapData with _$MapData {
  const factory MapData({
    required LatLng mapTarget,
    required List<TrainerEntity> coordinates,
}) = _MapData;
}
