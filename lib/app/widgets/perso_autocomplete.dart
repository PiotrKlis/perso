import 'package:Perso/app/utils/colors.dart';
import 'package:Perso/app/utils/theme_text.dart';
import 'package:Perso/core/dependency_injection/get_it_config.dart';
import 'package:Perso/data/address_provider/address_provider.dart';
import 'package:Perso/data/address_provider/google_address_provider.dart';
import 'package:flutter/material.dart';


class PersoAutocomplete extends StatelessWidget {
  PersoAutocomplete({super.key});

  final AddressProvider _addressProvider = getIt.get<GoogleAddressProvider>();
  TextEditingController? autocompleteController;

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
        autocompleteController = controller;
        return TextFormField(
          controller: controller,
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
        return suggestions;
      },
      onSelected: (String selection) {
        //no-op
      },
    );
  }
}
