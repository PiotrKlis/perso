import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perso/app/styleguide/value/app_colors.dart';
import 'package:perso/app/styleguide/value/app_typography.dart';
import 'package:perso/app/widgets/address/address_cubit.dart';
import 'package:perso/app/widgets/address_and_map/bloc/addres_and_map_bloc.dart';
import 'package:perso/app/widgets/address_and_map/state/address_and_map_state.dart';

class PersoAddress extends StatelessWidget {
  PersoAddress({
    super.key,
    this.initialAddress = '',
  });

  String initialAddress;
  TextEditingController? autocompleteController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddressAndMapBloc, AddressAndMapState>(
      builder: (context, state) {
        return Autocomplete<String>(
          initialValue: TextEditingValue(text: initialAddress),
          fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
            autocompleteController = controller;
            return TextFormField(
              controller: autocompleteController,
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
          optionsBuilder: (TextEditingValue textEditingValue) {
            final input = textEditingValue.text;
            if (input == '') {
              return const [];
            } else {
              context.read<AddressCubit>().fetchAddressSuggestions(input);
              return context.watch<AddressCubit>().state;
            }
            return List.of([]);
            // final suggestions =
            // await _addressProvider.fetchAddressSuggestions(input);
            // return suggestions.map((suggestion) => suggestion);
          },
          onSelected: (String address) {
            context.read<AddressCubit>().updateMap(address);
          },
        );
        state.when(
          initial: () {},
          mapUpdate: (latLng) {},
          addressUpdate: (address) {},
        );
      },
    );
  }
}
