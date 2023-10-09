import 'dart:async';

import 'package:Perso/app/screens/home/bloc/home_bloc.dart';
import 'package:Perso/app/screens/home/event/home_event.dart';
import 'package:Perso/app/screens/home/state/home_state.dart';
import 'package:Perso/app/screens/home/widgets/perso_account_icon.dart';
import 'package:Perso/app/utils/colors.dart';
import 'package:Perso/app/utils/dimens.dart';
import 'package:Perso/app/widgets/perso_big_header.dart';
import 'package:Perso/app/widgets/perso_button.dart';
import 'package:Perso/app/widgets/perso_clickable_text.dart';
import 'package:Perso/app/widgets/perso_header.dart';
import 'package:Perso/app/widgets/perso_search.dart';
import 'package:Perso/app/widgets/trainers_list/perso_trainers_list.dart';
import 'package:Perso/app/widgets/trainers_search_carousel/perso_trainers_search_carousel.dart';
import 'package:Perso/app/widgets/training_category_list/perso_training_category_list.dart';
import 'package:Perso/core/navigation/screen_navigation_key.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Map<String, String> _locations = {};
  bool _isLocationChecked = false;
  GoogleMapController? mapController;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(children: [
            GestureDetector(
                onTap: () => _handleAccountClick(context),
                child: const PersoAccountIcon()),
            Container(
              margin: const EdgeInsets.only(
                  top: Dimens.normalMargin,
                  left: Dimens.normalMargin,
                  right: Dimens.normalMargin),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PersoBigHeader(
                      title: AppLocalizations.of(context)!.home_main_header,
                    ),
                    //TODO: Make this button invisible if user is logged in
                    PersoButton(
                        onTap: (context) => _handleAccountClick(context),
                        title: AppLocalizations.of(context)!
                            .trainers_section_button,
                        width: Dimens.smallButtonWidth)
                  ]),
            ),
            Container(
                margin: const EdgeInsets.only(
                    left: Dimens.normalMargin,
                    top: Dimens.normalMargin,
                    right: Dimens.normalMargin),
                child: GestureDetector(
                    onTap: () => context.pushNamed(ScreenNavigationKey.search),
                    child: const AbsorbPointer(child: PersoSearch()))),
            Container(
              margin: const EdgeInsets.only(
                  top: Dimens.bigMargin,
                  left: Dimens.normalMargin,
                  right: Dimens.normalMargin),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PersoHeader(
                      title: AppLocalizations.of(context)!.category_header),
                  GestureDetector(
                    onTap: () =>
                        context
                            .pushNamed(ScreenNavigationKey.trainingCategories),
                    child: PersoClickableText(
                        title:
                        AppLocalizations.of(context)!.see_all_categories),
                  )
                ],
              ),
            ),
            Container(
                margin: const EdgeInsets.only(
                    left: Dimens.normalMargin, top: Dimens.bigMargin),
                child: const PersoTrainingCategoryList(isShortList: true)),
            Container(
              color: PersoColors.lightBlue,
              child: Column(
                children: [
                  Container(
                      margin: const EdgeInsets.only(top: Dimens.bigMargin),
                      child: PersoTrainersSearchCarousel()),
                  Container(
                    margin: const EdgeInsets.only(
                        top: Dimens.bigMargin,
                        left: Dimens.smallMargin,
                        right: Dimens.smallMargin),
                    child: SizedBox(
                      height: 300.0,
                      width: double.infinity,
                      child: _googleMap(),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        top: Dimens.bigMargin,
                        left: Dimens.normalMargin,
                        right: Dimens.normalMargin),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PersoHeader(
                            title: AppLocalizations.of(context)!.near_you),
                        GestureDetector(
                          onTap: () =>
                              context.pushNamed(
                                  ScreenNavigationKey.searchResults,
                                  pathParameters: {
                                    "input": "see all trainers near my location"
                                  }),
                          child: PersoClickableText(
                              title: AppLocalizations.of(context)!
                                  .see_all_categories),
                        )
                      ],
                    ),
                  ),
                  const PersoTrainersList()
                ],
              ),
            ),
            BlocProvider(
              create: (context) => HomeBloc(const HomeState.initial()),
              child:
              BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
                state.when(
                  initial: () => _getLocation(),
                  navigateToClientProfile: () =>
                      context.pushNamed(ScreenNavigationKey.clientProfile),
                  navigateToSignIn: () =>
                      context.pushNamed(ScreenNavigationKey.signIn),
                  navigateToTrainerProfile: () =>
                      context.pushNamed(ScreenNavigationKey.trainerProfile),
                );
                return Container();
              }),
            ),
          ]),
        ),
      ),
    );
  }

  GoogleMap _googleMap() {
    CameraPosition cameraPosition = const CameraPosition(
        target: LatLng(0.0, 19.479766023156003), zoom: 5.5);

    final Set<Marker> markers = {};
    markers.add(const Marker(markerId: MarkerId("1"), position: LatLng(0, 0)));
    for (var location in _locations.entries) {
      markers.add(Marker(
          markerId: const MarkerId("1"),
          position: LatLng(
              double.parse(location.key), double.parse(location.value))));
      cameraPosition = CameraPosition(
          target: LatLng(
              double.parse(location.key), double.parse(location.value)),
          zoom: 17);
    }

    return GoogleMap(
      markers: markers,
      gestureRecognizers: {
        Factory<OneSequenceGestureRecognizer>(() => EagerGestureRecognizer())
      },
      initialCameraPosition: cameraPosition,
      onMapCreated: (GoogleMapController controller) {
        mapController = controller;
      },
    );
  }

  void _getLocation() {
    _getLocationData().then((location) {
      String? latitude = location?.latitude.toString();
      String? longitude = location?.longitude.toString();
      _locations.forEach((key, value) {
        if (key == latitude && value == longitude) {
          return;
        }
      });
      if (latitude != null && longitude != null && !_isLocationChecked) {
        setState(() {
          _isLocationChecked = true;
          _locations.addAll({latitude: longitude});
          mapController?.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(
                  target: LatLng(double.parse(latitude),
                      double.parse(longitude)),
                  zoom: 11)));
        });
      }
    });
  }

  Future<LocationData?> _getLocationData() async {
    Location location = Location();
    LocationData _locationData;

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    _locationData = await location.getLocation();

    return _locationData;
  }

  void _handleAccountClick(BuildContext context) {
    context.read<HomeBloc>().add(const HomeEvent.accountNavigation());
  }
}
