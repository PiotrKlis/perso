import 'package:Perso/app/utils/colors.dart';
import 'package:Perso/app/utils/dimens.dart';
import 'package:Perso/app/utils/theme_text.dart';
import 'package:flutter/material.dart';

class PersoTextField extends StatelessWidget {
  const PersoTextField(
      {super.key,
      required this.title,
      this.customValidator,
      this.isPassword = false});

  final String title;
  final String? Function(String value)? customValidator;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      margin: const EdgeInsets.only(left: Dimens.normalMargin),
      child: TextFormField(
        obscureText: isPassword,
        validator: (value) {
          return customValidator?.call(value ?? "");
        },
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            errorMaxLines: 2,
            focusedBorder: const OutlineInputBorder(
                borderSide:
                    BorderSide(width: 0.5, color: PersoColors.lightGrey)),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 0.5, color: PersoColors.lightGrey),
            ),
            labelText: title,
            labelStyle: ThemeText.bodyRegularGreyText),
      ),
    );
  }
}
