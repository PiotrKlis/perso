import 'package:Perso/app/utils/dimens.dart';
import 'package:Perso/app/utils/theme_text.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';

class PersoSmallButton extends StatelessWidget {
  const PersoSmallButton(
      {Key? key,
      required this.text,
      required this.addLanguage,
      required this.customValidator})
      : super(key: key);

  final String text;
  final void Function(String value) addLanguage;
  final String? Function() customValidator;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200.0,
      child: TextFormField(
        validator: (_) => customValidator.call(),
        readOnly: true,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: text,
          hintStyle: ThemeText.bodyRegularBlue,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimens.buttonBorderRadius),
              borderSide: BorderSide.none),
        ),
        onTap: () {
          showCountryPicker(
            onClosed: () {

            },
            useSafeArea: true,
            favorite: ["PL", "GB", "UA"],
            context: context,
            onSelect: (value) {
              String emoji = value.flagEmoji;
              addLanguage.call(emoji);
            },
          );
        },
      ),
    );
  }
}
