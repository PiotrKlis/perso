import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:perso/app/styleguide/value/app_colors.dart';
import 'package:perso/app/styleguide/value/app_typography.dart';
import 'package:perso/app/widgets/address_and_map/bloc/addres_and_map_bloc.dart';
import 'package:perso/app/widgets/address_and_map/event/address_and_map_event.dart';
import 'package:perso/app/widgets/address_and_map/state/address_and_map_state.dart';
import 'package:perso/core/dependency_injection/get_it.dart';
import 'package:perso/data/address_provider/address_provider.dart';
import 'package:perso/data/address_provider/google_address_provider.dart';

class PersoAutocomplete extends StatelessWidget {
  PersoAutocomplete({super.key, this.initialAddress});

  String? initialAddress;

  TextEditingController? autocompleteController;

  final AddressProvider _addressProvider = getIt.get<GoogleAddressProvider>();

  Timer? _debounce;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddressAndMapBloc, AddressAndMapState>(
      builder: (context, state) {
        return _AutocompleteWidget();
        state.when(
          initial: () {

          },
          mapUpdate: (latLng) {},
          addressUpdate: (address) {},
        );
      },
    );
  }

  void cancelTimer() {
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }
  }
}

class _AutocompleteWidget extends StatelessWidget {
  const _AutocompleteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      // initialValue: TextEditingValue(text: initialAddress ?? ''),
      fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
        // autocompleteController = controller;
        return TextFormField(
          // controller: autocompleteController,
          focusNode: focusNode,
          decoration: const InputDecoration(
            filled: true,
            fillColor: Colors.white,
            errorMaxLines: 2,
            focusedBorder: OutlineInputBorder(
              borderSide:
              BorderSide(width: 0.5, color: PersoColors.lightGrey),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide:
              BorderSide(width: 0.5, color: PersoColors.lightGrey),
            ),
            labelText: 'Location',
            labelStyle: ThemeText.bodyRegularGreyText,
          ),
        );
      },
      optionsBuilder: (TextEditingValue textEditingValue) async {
        final input = textEditingValue.text;
        if (input == '') {
          return const Iterable<String>.empty();
        }
        return List.of([]);
        // final suggestions =
        // await _addressProvider.fetchAddressSuggestions(input);
        // return suggestions.map((suggestion) => suggestion);
      },
      onSelected: (String address) async {
        final locations = await locationFromAddress(address);
        if (locations.isNotEmpty) {
          final location = locations.first;
          final latLng = LatLng(location.latitude, location.longitude);
          context
              .read<AddressAndMapBloc>()
              .add(AddressAndMapEvent.updateMap(latLng));
        }
      },
    );
  }
}

