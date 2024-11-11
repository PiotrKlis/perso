import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:perso/app/screens/profile_edit/profile_edit_cubit.dart';
import 'package:perso/app/screens/profile_edit/profile_edit_state.dart';
import 'package:perso/app/styleguide/styleguide.dart';
import 'package:perso/app/utils/constants.dart';
import 'package:perso/app/widgets/map/map_cubit.dart';
import 'package:perso/app/widgets/map/map_state.dart';
import 'package:perso/core/models/trainer_entity.dart';
import 'package:perso/core/navigation/screen_navigation_key.dart';

class EditablePersoGoogleMap extends StatefulWidget {
  const EditablePersoGoogleMap({LatLng? navigateToLocation, super.key})
      : _navigateToLocation = navigateToLocation;

  static const _zoomOnMap = 15.0;
  final LatLng? _navigateToLocation;

  @override
  State<EditablePersoGoogleMap> createState() => _EditablePersoGoogleMapState();
}

class _EditablePersoGoogleMapState extends State<EditablePersoGoogleMap> {
  static const _initialCameraPosition = CameraPosition(
    target: Constants.initialLatLng,
    zoom: Constants.initialMapZoom,
  );
  Set<Marker> _markers = {};
  GoogleMapController? mapController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapCubit, MapState>(
      builder: (context, state) {
        state.when(
          initial: () {
            if (widget._navigateToLocation != null) {
              _updateCamera(widget._navigateToLocation!);
              _updateMarkers([], widget._navigateToLocation!);
            } else {
              context.read<MapCubit>().navigateToCurrentLocation();
            }
          },
          mapUpdate: (mapData) {
            _updateCamera(mapData.mapTarget);
            _updateMarkers(mapData.trainers, mapData.mapTarget);
          },
        );
        return BlocListener<ProfileEditCubit, ProfileEditState>(
          listener: (context, state) {
            state.whenOrNull(
              sendData: () {
                context
                    .read<ProfileEditCubit>()
                    .updateLatLng(_markers.last.position);
              },
            );
          },
          child: Container(
            margin: const EdgeInsets.only(
              left: Dimens.mMargin,
              right: Dimens.mMargin,
            ),
            child: SizedBox(
              height: Dimens.googleMapContainerHeight,
              width: double.infinity,
              child: GoogleMap(
                myLocationEnabled: true,
                markers: _markers,
                gestureRecognizers: const {
                  Factory<OneSequenceGestureRecognizer>(
                    EagerGestureRecognizer.new,
                  ),
                },
                initialCameraPosition: _initialCameraPosition,
                onMapCreated: (GoogleMapController controller) {
                  mapController = controller;
                },
              ),
            ),
          ),
        );
      },
    );
  }

  void _updateCamera(LatLng latLng) {
    mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: latLng, zoom: EditablePersoGoogleMap._zoomOnMap),
      ),
    );
  }

  void _updateMarkers(List<TrainerEntity> trainers, LatLng mapTarget) {
    final markers = trainers.map<Marker>((trainer) {
      return Marker(
        markerId: MarkerId(trainer.id),
        position: trainer.latLng,
        infoWindow: InfoWindow(
          title: '${trainer.name} ${trainer.surname}',
          snippet: trainer.nickname,
          onTap: () {
            context.pushNamed(
              ScreenNavigationKey.trainerDetails,
              extra: trainer,
            );
          },
        ),
      );
    }).toSet();
    markers.add(
      Marker(
        draggable: true,
        position: mapTarget,
        markerId: const MarkerId('my marker'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        infoWindow: const InfoWindow(
          title: 'Your pin',
          snippet: 'Long press to move',
        ),
        onDragEnd: (newLatLng) {
          final userMarker = markers.last;
          final updatedMarker = userMarker.copyWith(positionParam: newLatLng);
          _markers
            ..remove(userMarker)
            ..add(updatedMarker);
        },
      ),
    );
    _markers = markers;
  }
}
