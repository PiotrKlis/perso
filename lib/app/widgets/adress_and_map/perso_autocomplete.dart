import 'dart:async';

import 'package:Perso/app/utils/colors.dart';
import 'package:Perso/app/utils/theme_text.dart';
import 'package:Perso/app/widgets/adress_and_map/bloc/addres_and_map_bloc.dart';
import 'package:Perso/app/widgets/adress_and_map/event/address_and_map_event.dart';
import 'package:Perso/app/widgets/adress_and_map/state/address_and_map_state.dart';
import 'package:Perso/core/dependency_injection/get_it_config.dart';
import 'package:Perso/data/address_provider/address_provider.dart';
import 'package:Perso/data/address_provider/google_address_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PersoAutocomplete extends StatelessWidget {
  final AddressProvider _addressProvider = getIt.get<GoogleAddressProvider>();
  TextEditingController? autocompleteController;
  Timer? _debounce;

  PersoAutocomplete({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddressAndMapBloc, AddressAndMapState>(
      builder: (context, state) => Autocomplete<String>(
        fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
          autocompleteController = controller;
          return TextFormField(
            controller: autocompleteController,
            focusNode: focusNode,
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                errorMaxLines: 2,
                focusedBorder: const OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 0.5, color: PersoColors.lightGrey)),
                enabledBorder: const OutlineInputBorder(
                  borderSide:
                      BorderSide(width: 0.5, color: PersoColors.lightGrey),
                ),
                labelText: "Location",
                labelStyle: ThemeText.bodyRegularGreyText),
          );
        },
        optionsBuilder: (TextEditingValue textEditingValue) async {
          String input = textEditingValue.text;
          if (input == "") {
            return const Iterable<String>.empty();
          }
          List<String> suggestions =
              await _addressProvider.fetchSuggestions(input);
          return suggestions.map((suggestion) => suggestion);
        },
        onSelected: (String address) async {
          List<Location> locations = await locationFromAddress(address);
          if (locations.isNotEmpty) {
            Location location = locations.first;
            LatLng latLng = LatLng(location.latitude, location.longitude);
            context
                .read<AddressAndMapBloc>()
                .add(AddressAndMapEvent.updateMap(latLng));
          }
        },
      ),
    );
  }

  void cancelTimer() {
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }
  }
}
