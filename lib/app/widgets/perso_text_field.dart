import 'package:Perso/app/utils/dimens.dart';
import 'package:Perso/app/utils/theme_text.dart';
import 'package:flutter/material.dart';

class PersoTextField extends StatelessWidget {
  const PersoTextField({
    required this.title,
    this.customValidator,
    Key? key,
  }) : super(key: key);
  final String title;
  final String? Function(String value)? customValidator;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
          left: Dimens.biggerMargin, right: Dimens.biggerMargin),
      child: TextFormField(
        validator: (value) {
          return customValidator?.call(value ?? "");
        },
        textAlign: TextAlign.center,
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.zero,
            errorMaxLines: 2,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimens.textFieldBorderRadius),
              borderSide: BorderSide.none,
            ),
            hintText: title,
            labelStyle: ThemeText.bodyRegularBlackText),
      ),
    );
  }
}
