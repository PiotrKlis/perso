import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'place_info.freezed.dart';

@freezed
class PlaceInfo with _$PlaceInfo {
  const factory PlaceInfo({
    required String address,
    required LatLng latLng,
  }) = _PlaceInfo;
}
