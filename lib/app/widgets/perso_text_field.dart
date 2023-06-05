import 'package:Perso/app/utils/colors.dart';
import 'package:Perso/app/utils/theme_text.dart';
import 'package:flutter/material.dart';

class PersoTextField extends StatefulWidget {
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
  State<PersoTextField> createState() => _PersoTextFieldState();
}

class _PersoTextFieldState extends State<PersoTextField> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: widget.maxLength,
      obscureText: widget.shouldObscureText,
      keyboardType:
          widget.isMultiLine ? TextInputType.multiline : widget.textInputType,
      maxLines: widget.isMultiLine ? null : 1,
      expands: widget.isMultiLine ? true : false,
      textAlignVertical: TextAlignVertical.top,
      validator: (value) => widget.customValidator?.call(value ?? ""),
      decoration: InputDecoration(
          counterText: widget.isMultiLine ? null : "",
          filled: true,
          fillColor: Colors.white,
          errorMaxLines: 2,
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 0.5, color: PersoColors.lightGrey)),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 0.5, color: PersoColors.lightGrey),
          ),
          labelText: widget.title,
          labelStyle: ThemeText.bodyRegularGreyText),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
