import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:perso/app/styleguide/styleguide.dart';
import 'package:perso/app/utils/constants.dart';
import 'package:perso/app/widgets/map/map_cubit.dart';
import 'package:perso/app/widgets/map/map_state.dart';
import 'package:perso/core/models/trainer_entity.dart';
import 'package:perso/core/navigation/screen_navigation_key.dart';

class PersoGoogleMap extends StatefulWidget {
  const PersoGoogleMap({super.key, this.trainerEntity});

  static const _zoomOnMap = 15.0;
  final TrainerEntity? trainerEntity;

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
            if (widget.trainerEntity != null) {
              _updateCamera(widget.trainerEntity!.latLng);
              _updateMarkers([widget.trainerEntity!], mapData.mapTarget);
            } else {
              _updateCamera(mapData.mapTarget);
              _updateMarkers(mapData.trainers, mapData.mapTarget);
            }
          },
        );
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

  void _updateMarkers(List<TrainerEntity> trainers, LatLng mapTarget) {
    _markers = trainers.map<Marker>((trainer) {
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
  }
}
