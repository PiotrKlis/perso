import 'package:Perso/app/utils/colors.dart';
import 'package:Perso/data/google/place_service.dart';
import 'package:flutter/material.dart';

import '../utils/theme_text.dart';

class PersoAutocomplete extends StatelessWidget {
  PersoAutocomplete({Key? key}) : super(key: key);
  static const List<String> _kOptions = <String>[
    'aardvark',
    'bobcat',
    'chameleon',
  ];

  final PlaceApiProvider _placeApiProvider = PlaceApiProvider();

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
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<String>.empty();
        }
        return _kOptions.where((String option) {
          return option.contains(textEditingValue.text.toLowerCase());
        });
      },
      onSelected: (String selection) {
        debugPrint('You just selected $selection');
      },
    );
  }
}
