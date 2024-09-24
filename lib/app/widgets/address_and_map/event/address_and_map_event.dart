import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
part 'address_and_map_event.freezed.dart';

@freezed
class AddressAndMapEvent with _$AddressAndMapEvent {
  const factory AddressAndMapEvent.updateMap(LatLng latLng) = UpdateMap;
  const factory AddressAndMapEvent.updateAddress(LatLng latLng) = UpdateAddress;
}
