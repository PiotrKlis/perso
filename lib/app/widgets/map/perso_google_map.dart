import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:perso/app/screens/profile_edit/profile_edit_cubit.dart';
import 'package:perso/app/styleguide/styleguide.dart';
import 'package:perso/app/utils/constants.dart';
import 'package:perso/app/widgets/map/map_cubit.dart';
import 'package:perso/app/widgets/map/map_state.dart';
import 'package:perso/core/models/trainer_entity.dart';
import 'package:uuid/uuid.dart';

class PersoGoogleMap extends StatefulWidget {
  const PersoGoogleMap({super.key, bool shouldShowMarkerAtTheCenter = false})
      : _shouldShowMarkerAtTheCenter = shouldShowMarkerAtTheCenter;

  static const _zoomOnMap = 15.0;
  final bool _shouldShowMarkerAtTheCenter;

  @override
  State<PersoGoogleMap> createState() => _PersoGoogleMapState();
}

class _PersoGoogleMapState extends State<PersoGoogleMap> {
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
            context.read<MapCubit>().navigateToCurrentLocation();
          },
          mapUpdate: (mapData) {
            _updateCamera(mapData.mapTarget);
            _updateMarkers(mapData.coordinates);
          },
        );
        if (widget._shouldShowMarkerAtTheCenter) {
          context.watch<ProfileEditCubit>().state.whenOrNull(
            sendData: () {
              context
                  .read<ProfileEditCubit>()
                  .updateLatLng(_markers.first.position);
            },
          );
        }
        return Container(
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
              onCameraMove: (position) {
                if (widget._shouldShowMarkerAtTheCenter) {
                  // mapController(position.target);
                }
              },
            ),
          ),
        );
      },
    );
  }

  void _updateCamera(LatLng latLng) {
    mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: latLng, zoom: PersoGoogleMap._zoomOnMap),
      ),
    );
  }

  void _updateMarkers(List<TrainerEntity> trainers) {
    _markers = trainers.map<Marker>((trainer) {
      return Marker(
        markerId: MarkerId(trainer.id),
        position: trainer.latLng,
        infoWindow: InfoWindow(
          title: '${trainer.name} ${trainer.surname}',
          // snippet: 'Bardzo dlugi tekst ojezusmaria jaki dlugi Bardzo dlugi ',
          snippet: trainer.nickname,
        ),
      );
    }).toSet();
  }
}
