import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perso/app/screens/profile_edit/profile_edit_cubit.dart';
import 'package:perso/app/screens/profile_edit/profile_edit_state.dart';
import 'package:perso/app/styleguide/value/app_colors.dart';
import 'package:perso/app/styleguide/value/app_typography.dart';
import 'package:perso/app/widgets/address/address_cubit.dart';
import 'package:perso/app/widgets/map/map_cubit.dart';
import 'package:perso/core/extensions/context_extensions.dart';

class PersoAddress extends StatefulWidget {
  const PersoAddress({
    super.key,
    String address = '',
  }) : _address = address;

  final String _address;

  @override
  State<PersoAddress> createState() => _PersoAddressState();
}

class _PersoAddressState extends State<PersoAddress> {
  TextEditingController? autocompleteController;
  TextEditingValue initialValue = TextEditingValue.empty;

  @override
  void initState() {
    initialValue = TextEditingValue(text: widget._address);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileEditCubit, ProfileEditState>(
      builder: (context, state) {
        state.whenOrNull(
          sendData: () {
            context
                .read<ProfileEditCubit>()
                .updateAddress(autocompleteController?.text ?? '');
          },
        );
        return Autocomplete<String>(
          initialValue: initialValue,
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
                      BorderSide(width: 0.5, color: PersoColors.lightGrey),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide:
                      BorderSide(width: 0.5, color: PersoColors.lightGrey),
                ),
                labelText: context.strings.address,
                labelStyle: ThemeText.bodyRegularGreyText,
              ),
            );
          },
          optionsBuilder: (TextEditingValue textEditingValue) {
            final input = textEditingValue.text;
            if (input.isEmpty) {
              return const [];
            } else {
              //TODO: Add debounce
              final suggestions =
                  context.read<AddressCubit>().fetchAddressSuggestions(input);
              return suggestions;
            }
          },
          onSelected: (String address) {
            autocompleteController?.text = address;
            context.read<MapCubit>().updateMap(address);
          },
        );
      },
    );
  }
}
