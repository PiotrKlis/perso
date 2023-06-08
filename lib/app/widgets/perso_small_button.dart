import 'package:Perso/app/utils/dimens.dart';
import 'package:Perso/app/utils/theme_text.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';

class PersoSmallButton extends StatelessWidget {
  const PersoSmallButton(
      {Key? key,
      required this.text,
      required this.addLanguage})
      : super(key: key);

  final String text;
  final void Function(String value) addLanguage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: Dimens.loginButtonHeight,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(Dimens.buttonBorderRadius))),
            onPressed: () {
              showCountryPicker(
                  useSafeArea: true,
                  favorite: ["PL", "GB", "UA"],
                  context: context,
                  onSelect: (value) {
                    String emoji = value.flagEmoji;
                   addLanguage.call(emoji);
                  });
            },
            child: Text(text, style: ThemeText.bodyRegularBlue)));
  }
}
