import 'package:Perso/app/utils/colors.dart';
import 'package:Perso/app/utils/theme_text.dart';
import 'package:Perso/data/address_provider/address_provider.dart';
import 'package:Perso/data/address_provider/google_address_provider.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class PersoAutocomplete extends StatelessWidget {
  PersoAutocomplete({Key? key}) : super(key: key);

  final AddressProvider _addressProvider = GetIt.I.get<GoogleAddressProvider>();

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      fieldViewBuilder:
          (context, textEditingController, focusNode, onFieldSubmitted) {
        return TextFormField(
          controller: textEditingController,
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
