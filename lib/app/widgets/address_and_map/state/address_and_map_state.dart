import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
part 'address_and_map_state.freezed.dart';

@freezed
class AddressAndMapState with _$AddressAndMapState {
  const factory AddressAndMapState.initial() = Initial;
  const factory AddressAndMapState.mapUpdate(LatLng latLng) = MapUpdate;
}
