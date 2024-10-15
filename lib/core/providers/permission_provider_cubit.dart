import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:perso/core/dependency_injection/get_it.dart';
import 'package:perso/core/handlers/permission_handler.dart';

class PermissionProviderCubit extends Cubit<PermissionStatus> {
  PermissionProviderCubit() : super(PermissionStatus.denied);
  final _permissionHandler = getIt.get<PermissionHandler>();

  Future<void> checkLocationPermissionStatus() async {
    final permissionStatus =
        await _permissionHandler.locationPermissionStatus();
    emit(permissionStatus);
  }

  void changeLocationPermission() {
    _permissionHandler.requestLocationPermission();
  }
}
