import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:location/location.dart';
import 'package:perso/app/widgets/address/address_cubit.dart';
import 'package:perso/app/widgets/map/map_state.dart';
import 'package:perso/core/dependency_injection/get_it.dart';
import 'package:perso/core/handlers/permission_handler.dart';

@injectable
class MapCubit extends Cubit<MapState> {
  MapCubit() : super(const MapState.initial());
  final _addressCubit = getIt.get<AddressCubit>();
  final _permissionHandler = getIt.get<PermissionHandler>();

  Future<void> updateMap(String address) async {
    final locations = await geocoding.locationFromAddress(address);
    if (locations.isNotEmpty) {
      final location = locations.first;
      final latLng = LatLng(location.latitude, location.longitude);
      emit(MapState.mapUpdate(latLng));
    }
  }

  Future<void> navigateToCurrentLocation() async {
    await _permissionHandler.handleLocationPermission();
    final location = await Location().getLocation();
    final latitude = double.parse(location.latitude.toString());
    final longitude = double.parse(location.longitude.toString());
    emit(MapState.mapUpdate(LatLng(latitude, longitude)));
  }

  void updateAddress(LatLng latlng) {
    _addressCubit.updateAddress(latlng);
  }
}
