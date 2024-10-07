import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:perso/app/screens/profile_edit/profile_edit_cubit.dart';
import 'package:perso/app/screens/profile_edit/profile_edit_state.dart';
import 'package:perso/app/styleguide/styleguide.dart';
import 'package:perso/app/utils/constants.dart';
import 'package:perso/app/widgets/map/map_cubit.dart';
import 'package:perso/app/widgets/map/map_state.dart';

class PersoGoogleMap extends StatefulWidget {
  const PersoGoogleMap({super.key, bool shouldShowMarkerAtTheCenter = false})
      : _shouldShowMarkerAtTheCenter = shouldShowMarkerAtTheCenter;

  static const _zoomOnMap = 15.0;
  final bool _shouldShowMarkerAtTheCenter;

  @override
  State<PersoGoogleMap> createState() => _PersoGoogleMapState();
}

class _PersoGoogleMapState extends State<PersoGoogleMap> {
  late _MapWidget _mapWidget;

  @override
  Widget build(BuildContext context) {
    _mapWidget = _MapWidget(
        shouldShowMarkerAtTheCenter: widget._shouldShowMarkerAtTheCenter);
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
        CameraPosition(target: latLng, zoom: PersoGoogleMap._zoomOnMap),
      ),
    );
  }
}

class _MapWidget extends StatefulWidget {
  _MapWidget({required this.shouldShowMarkerAtTheCenter});

  GoogleMapController? mapController;
  final bool shouldShowMarkerAtTheCenter;

  @override
  State<_MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<_MapWidget> {
  static const _initialCameraPosition = CameraPosition(
    target: Constants.initialLatLng,
    zoom: Constants.initialMapZoom,
  );
  final Set<Marker> _markers = {};

  @override
  Widget build(BuildContext context) {
    if (widget.shouldShowMarkerAtTheCenter) {
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
            widget.mapController = controller;
          },
          onCameraMove: (position) {
            if (widget.shouldShowMarkerAtTheCenter) {
              _updateMarker(position.target);
            }
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
