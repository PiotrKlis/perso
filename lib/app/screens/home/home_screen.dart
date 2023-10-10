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
  final List<LatLng> _locations = [];
  final Set<Marker> _markers = {};
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
                    onTap: () => context
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
                        left: Dimens.normalMargin,
                        right: Dimens.normalMargin),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PersoHeader(
                            title: AppLocalizations.of(context)!.near_you),
                        GestureDetector(
                          onTap: () => context.pushNamed(
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
                  Container(
                    margin: const EdgeInsets.only(
                        top: Dimens.smallMargin,
                        left: Dimens.smallMargin,
                        right: Dimens.smallMargin),
                    child: SizedBox(
                      height: 300.0,
                      width: double.infinity,
                      child: _googleMap(),
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: Dimens.smallMargin),
                      child: const PersoTrainersList())
                ],
              ),
            ),
            BlocProvider(
              create: (context) => HomeBloc(const HomeState.initial()),
              child:
                  BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
                state.when(
                  initial: () => _navigateCameraToCurrentLocation(),
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
    CameraPosition initialCameraPosition = const CameraPosition(
        target: LatLng(52.06923300336246, 19.479766023156003), zoom: 5.5);

    int markerId = 0;
    for (var location in _locations) {
      _markers.add(
          Marker(markerId: MarkerId(markerId.toString()), position: location));
      markerId++;
    }

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

  void _handleAccountClick(BuildContext context) {
    context.read<HomeBloc>().add(const HomeEvent.accountNavigation());
  }
}
