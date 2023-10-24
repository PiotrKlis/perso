import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:perso/app/styleguide/styleguide.dart';
import 'package:perso/app/widgets/adress_and_map/bloc/addres_and_map_bloc.dart';
import 'package:perso/app/widgets/adress_and_map/state/address_and_map_state.dart';

class PersoGoogleMap extends StatefulWidget {
  PersoGoogleMap({super.key, List<LatLng> locations = const []})
      : _locations = locations;

  final List<LatLng> _locations;

  @override
  State<PersoGoogleMap> createState() => _PersoGoogleMapState();
}

class _PersoGoogleMapState extends State<PersoGoogleMap> {
  final Set<Marker> _markers = {};
  GoogleMapController? mapController;

  @override
  Widget build(BuildContext context) {
    CameraPosition initialCameraPosition = const CameraPosition(
        target: LatLng(52.06923300336246, 19.479766023156003), zoom: 5.5);
    return BlocConsumer<AddressAndMapBloc, AddressAndMapState>(
      listener: (context, state) {
        state.whenOrNull(
          mapUpdate: (latLng) {
            mapController?.animateCamera(CameraUpdate.newCameraPosition(
                CameraPosition(target: latLng, zoom: 15)));
            SchedulerBinding.instance.addPostFrameCallback((_) {
              setState(() {
                _markers.add(Marker(
                    markerId: MarkerId(hashCode.toString()), position: latLng));
              });
            });
          },
        );
      },
      builder: (context, state) =>
          BlocBuilder<AddressAndMapBloc, AddressAndMapState>(
              builder: (context, state) {
        state.whenOrNull(
          initial: () {
            print("init");
          },
        );
        return Container(
          margin: const EdgeInsets.only(
              left: Dimens.mediumMargin, right: Dimens.mediumMargin),
          child: SizedBox(
            height: 300.0,
            width: double.infinity,
            child: GoogleMap(
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              markers: _markers,
              gestureRecognizers: {
                Factory<OneSequenceGestureRecognizer>(
                    () => EagerGestureRecognizer())
              },
              initialCameraPosition: initialCameraPosition,
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
              },
            ),
          ),
        );
      }),
    );
  }

  @override
  void initState() {
    _navigateCameraToCurrentLocation();
    super.initState();
  }

  //TODO: Change below into bloc implementation
  void _navigateCameraToCurrentLocation() {
    _getCurrentLocation().then((location) {
      double latitude = double.parse(location.latitude.toString());
      double longitude = double.parse(location.longitude.toString());
      setState(() {
        mapController?.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(target: LatLng(latitude, longitude), zoom: 11)));
      });
    }).onError((error, stackTrace) {
      //TODO: Add error handling
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  Future<LocationData> _getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;

    //TODO: Extract serviceEnabled and permissionGranted into separate services
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return Future.error("Location service is not enabled");
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return Future.error("Location permission not granted");
      }
    }

    return await location.getLocation();
  }
}
