import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:perso/app/styleguide/styleguide.dart';
import 'package:perso/app/utils/constants.dart';
import 'package:perso/app/widgets/map/map_cubit.dart';
import 'package:perso/app/widgets/map/map_state.dart';

class PersoGoogleMap extends StatelessWidget {
  PersoGoogleMap({super.key});

  static const _zoomOnMap = 11.0;
  final _mapWidget = _Map();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapCubit, MapState>(
      builder: (context, state) {
        state.when(
          initial: () {
            context.read<MapCubit>().navigateToCurrentLocation();
          },
          mapUpdate: (latLng) {
            _updateCamera(latLng);
          },
        );
        return _mapWidget;
      },
    );
  }

  void _updateCamera(LatLng latLng) {
    _mapWidget.mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: latLng, zoom: _zoomOnMap),
      ),
    );
  }
}

class _Map extends StatefulWidget {
  GoogleMapController? mapController;

  @override
  State<_Map> createState() => _MapState();
}

class _MapState extends State<_Map> {
  static const _initialCameraPosition = CameraPosition(
    target: Constants.initialLatLng,
    zoom: Constants.initialMapZoom,
  );
  final Set<Marker> _markers = {};

  @override
  Widget build(BuildContext context) {
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
            widget.mapController = controller;
          },
          onCameraMove: (position) {
            _updateMarker(position.target);
          },
        ),
      ),
    );
  }

  void _updateMarker(LatLng latLng) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _markers
          ..clear()
          ..add(
            Marker(
              markerId: MarkerId(hashCode.toString()),
              position: latLng,
            ),
          );
      });
    });
  }
}
