import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class PersoGoogleMap extends StatefulWidget {
  PersoGoogleMap({super.key});

  @override
  State<PersoGoogleMap> createState() => _PersoGoogleMapState();
}

class _PersoGoogleMapState extends State<PersoGoogleMap> {
  final List<LatLng> _locations = [];
  final Set<Marker> _markers = {};
  GoogleMapController? mapController;
  bool _isLocationChecked = false;

  @override
  Widget build(BuildContext context) {
    CameraPosition initialCameraPosition = const CameraPosition(
        target: LatLng(52.06923300336246, 19.479766023156003), zoom: 5.5);

    int markerId = 0;
    for (var location in _locations) {
      _markers.add(
          Marker(markerId: MarkerId(markerId.toString()), position: location));
      markerId++;
    }

    _navigateCameraToCurrentLocation();

    return GoogleMap(
      myLocationButtonEnabled: true,
      myLocationEnabled: true,
      markers: _markers,
      gestureRecognizers: {
        Factory<OneSequenceGestureRecognizer>(() => EagerGestureRecognizer())
      },
      initialCameraPosition: initialCameraPosition,
      onMapCreated: (GoogleMapController controller) {
        mapController = controller;
      },
    );
  }

  //TODO: Change below into bloc implementation
  void _navigateCameraToCurrentLocation() {
    _getCurrentLocation().then((location) {
      double latitude = double.parse(location.latitude.toString());
      double longitude = double.parse(location.longitude.toString());
      if (!_isLocationChecked) {
        setState(() {
          _isLocationChecked = true;
          mapController?.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(target: LatLng(latitude, longitude), zoom: 11)));
        });
      }
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
