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
      this.isMultiLine = false,
      this.maxLength = 60});

  final String title;
  final String? Function(String value)? customValidator;
  final bool shouldObscureText;
  final TextInputType textInputType;
  final bool isMultiLine;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: maxLength,
      obscureText: shouldObscureText,
      keyboardType: isMultiLine ? TextInputType.multiline : textInputType,
      maxLines: isMultiLine ? null : 1,
      expands: isMultiLine ? true : false,
      textAlignVertical: TextAlignVertical.top,
      validator: (value) => customValidator?.call(value ?? ""),
      decoration: InputDecoration(
          counterText: isMultiLine ? null : "",
          filled: true,
          fillColor: Colors.white,
          errorMaxLines: 2,
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 0.5, color: PersoColors.lightGrey)),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 0.5, color: PersoColors.lightGrey),
          ),
          labelText: title,
          labelStyle: ThemeText.bodyRegularGreyText),
    );
  }
}
