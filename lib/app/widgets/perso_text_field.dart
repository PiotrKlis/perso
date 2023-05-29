import 'package:Perso/app/utils/colors.dart';
import 'package:Perso/app/utils/theme_text.dart';
import 'package:flutter/material.dart';

class PersoTextField extends StatelessWidget {
  const PersoTextField(
      {super.key,
      required this.title,
      this.customValidator,
      this.shouldObscureText = false,
      this.textInputType = TextInputType.text,
      this.isMultiLine = false});

  final String title;
  final String? Function(String value)? customValidator;
  final bool shouldObscureText;
  final TextInputType textInputType;
  final bool isMultiLine;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: shouldObscureText,
      keyboardType: isMultiLine ? TextInputType.multiline : textInputType,
      // expands: isMultiLine ? true : false,
      // maxLines: isMultiLine ? null : 1,
      validator: (value) => customValidator?.call(value ?? ""),
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
    );
  }
}
