import 'package:Perso/app/utils/dimens.dart';
import 'package:Perso/app/utils/theme_text.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';

class PersoSmallButton extends StatelessWidget {
  const PersoSmallButton({Key? key}) : super(key: key);

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
                showCountryPicker(context: context, onSelect: (value) {
                  // Add new country chip
                });
            },
            child: Text(
              "Add",
              style: ThemeText.bodyRegularBlue,
            )));
  }
}
