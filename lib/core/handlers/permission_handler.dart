import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';

@injectable
class PermissionHandler {
  Future<void> requestLocationPermission() async {
    if (await Permission.location.isDenied) {
      await Permission.location.request();
    }
  }

  Future<PermissionStatus> locationPermissionStatus() async {
    return Permission.location.status;
  }
}
