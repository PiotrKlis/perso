import 'dart:convert';

import 'package:google_maps_flutter_platform_interface/src/types/location.dart';
import 'package:http/http.dart';
import 'package:injectable/injectable.dart';
import 'package:perso/data/address_provider/address_provider.dart';
import 'package:uuid/uuid.dart';

@singleton
class GoogleAddressProvider implements AddressProvider {
  final client = Client();
  final sessionToken = const Uuid().v4();

  final String apiKey = 'AIzaSyAFu6Z8q4klRZddcUjXZSAqluMZW8hcP1Q';

  @override
  Future<List<String>> fetchAddressSuggestions(String input) async {
    final request = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?'
        'input=$input&types=address&components=country:pl&'
        'key=$apiKey&sessiontoken=$sessionToken');

    final response = await client.get(request);

    if (response.statusCode == 200) {
      final result = json.decode(response.body) as Map<String, dynamic>;
      if (result['status'] == 'OK') {
        return (result['predictions'] as List<dynamic>)
            .map((prediction) => prediction['description'] as String)
            .toList();
      }
      if (result['status'] == 'ZERO_RESULTS') {
        return [];
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }

  @override
  Future<String> fetchAddress(LatLng latlng) async {
    final request = Uri.parse(
      'https://maps.googleapis.com/maps/api/geocode/json?latlng=40.714224,-73.961452&key=$apiKey',
    );
    final response = await client.get(request);

    if (response.statusCode == 200) {
      print(response);
      return "Przyjaźni 20a/2a, Wrocław";
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }
}
