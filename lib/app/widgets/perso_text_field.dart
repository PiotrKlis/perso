import 'package:Perso/app/utils/dimens.dart';
import 'package:Perso/app/utils/theme_text.dart';
import 'package:flutter/material.dart';

class PersoTextField extends StatelessWidget {
  const PersoTextField({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimens.textFieldHeight,
      margin: const EdgeInsets.only(
          left: Dimens.biggerMargin, right: Dimens.biggerMargin),
      child: Card(
        elevation: 1.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimens.textFieldBorderRadius)
        ),
        child: TextFormField(
          textAlign: TextAlign.center,
          decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.zero,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Dimens.textFieldBorderRadius),
                borderSide: BorderSide.none,
              ),
              labelText: title,
              labelStyle: ThemeText.bodyRegularGreyText),
        ),
      ),
    );
  }
}
