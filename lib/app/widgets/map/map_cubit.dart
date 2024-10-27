import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:location/location.dart';
import 'package:perso/app/utils/constants.dart';
import 'package:perso/app/widgets/map/map_data.dart';
import 'package:perso/app/widgets/map/map_state.dart';
import 'package:perso/core/dependency_injection/get_it.dart';
import 'package:perso/core/handlers/permission_handler.dart';
import 'package:perso/core/models/trainer_entity.dart';
import 'package:perso/data/trainers/trainers_provider/firestore_trainers_provider.dart';

@singleton
class MapCubit extends Cubit<MapState> {
  MapCubit() : super(const MapState.initial());
  final _permissionHandler = getIt.get<PermissionHandler>();
  final _trainersProvider = getIt.get<FirestoreTrainersProvider>();
  List<TrainerEntity> _trainers = [];

  Future<void> updateMap(String address) async {
    final locations = await geocoding.locationFromAddress(address);
    if (locations.isNotEmpty) {
      final location = locations.first;
      final latLng = LatLng(location.latitude, location.longitude);
      emit(
        MapState.mapUpdate(
          MapData(mapTarget: latLng, coordinates: _trainers),
        ),
      );
    }
  }

  Future<void> navigateToCurrentLocation() async {
    _trainers = await _trainersProvider.getAllTrainersData();
    await _permissionHandler.requestLocationPermission();
    final location = await Location().getLocation();
    final latitude = location.latitude ?? Constants.initialLat;
    final longitude = location.longitude ?? Constants.initialLng;
    emit(
      MapState.mapUpdate(
        MapData(
          mapTarget: LatLng(latitude, longitude),
          coordinates: _trainers,
        ),
      ),
    );
  }
}
