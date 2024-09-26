import 'package:injectable/injectable.dart';
import 'package:location/location.dart';

@injectable
class PermissionHandler {
  Future<void> handleLocationPermission() async {
    final location = Location();
    final locationPermissionStatus = await location.hasPermission();
    if (locationPermissionStatus == PermissionStatus.denied) {
      await location.requestPermission();
    }
  }
}
