import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
part 'PlaceInfo.freezed.dart';

@freezed
class PlaceInfo with _$PlaceInfo {
  const factory PlaceInfo({
    required final String address,
    required final LatLng latLng,
  }) = _PlaceInfo;
}
