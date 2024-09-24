import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class AddressProvider {
  Future<List<String>> fetchAddressSuggestions(String input);
  Future<String> fetchAddress(LatLng latlng);
}
