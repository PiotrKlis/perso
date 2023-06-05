import 'dart:convert';

import 'package:http/http.dart';
import 'package:uuid/uuid.dart';

class Suggestion {
  final String placeId;
  final String description;

  Suggestion(this.placeId, this.description);

  @override
  String toString() {
    return 'Suggestion(description: $description, placeId: $placeId)';
  }
}

class PlaceApiProvider {
  final client = Client();
  final sessionToken = const Uuid().v4();

  final String apiKey = "AIzaSyAFu6Z8q4klRZddcUjXZSAqluMZW8hcP1Q";

  Future<List<Suggestion>> fetchSuggestions(String input) async {
    final Uri request = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&types=address&&key=$apiKey&sessiontoken=$sessionToken');
    final response = await client.get(request);

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        // compose suggestions in a list
        return result['predictions']
            .map<Suggestion>((prediction) =>
                Suggestion(prediction['place_id'], prediction['description']))
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

// Future<Place> getPlaceDetailFromId(String placeId) async {
// if you want to get the details of the selected place by place_id
// }
}
