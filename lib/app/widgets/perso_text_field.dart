import 'package:perso/app/styleguide/value/app_colors.dart';
import 'package:perso/app/styleguide/value/app_typography.dart';
import 'package:perso/app/utils/validators.dart';
import 'package:flutter/material.dart';

class PersoTextField extends StatefulWidget {
  const PersoTextField({
    super.key,
    required String title,
    String? Function(String)? customValidator,
    bool shouldObscureText = false,
    TextInputType textInputType = TextInputType.text,
    bool isMultiLine = false,
    int? maxLength = 60,
    TextEditingController? passwordController,
    TextEditingController? confirmPasswordController,
    TextEditingController? textEditingController,
  })  : _maxLength = maxLength,
        _isMultiLine = isMultiLine,
        _textInputType = textInputType,
        _shouldObscureText = shouldObscureText,
        _customValidator = customValidator,
        _title = title,
        _textEditingController = textEditingController,
        _confirmPasswordController = confirmPasswordController,
        _passwordController = passwordController;

  final String _title;
  final String? Function(String value)? _customValidator;
  final bool _shouldObscureText;
  final TextInputType _textInputType;
  final bool _isMultiLine;
  final int? _maxLength;
  final TextEditingController? _textEditingController;
  final TextEditingController? _passwordController;
  final TextEditingController? _confirmPasswordController;

  @override
  State<PersoTextField> createState() => _PersoTextFieldState();
}

class _PersoTextFieldState extends State<PersoTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget._confirmPasswordController ??
          widget._passwordController ??
          widget._textEditingController,
      maxLength: widget._maxLength,
      obscureText: widget._shouldObscureText,
      keyboardType:
          widget._isMultiLine ? TextInputType.multiline : widget._textInputType,
      maxLines: widget._isMultiLine ? null : 1,
      expands: widget._isMultiLine ? true : false,
      textAlignVertical: TextAlignVertical.top,
      validator: (value) => _handleValidation(value),
      decoration: InputDecoration(
          counterText: widget._isMultiLine ? null : "",
          filled: true,
          fillColor: Colors.white,
          errorMaxLines: 2,
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 0.5, color: PersoColors.lightGrey)),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 0.5, color: PersoColors.lightGrey),
          ),
          labelText: widget._title,
          labelStyle: ThemeText.bodyRegularGreyText),
    );
  }

  String? _handleValidation(String? value) {
    if (widget._confirmPasswordController != null) {
      return TextFieldValidator.validateSameText(
          value ?? "", widget._passwordController?.text ?? "");
    } else {
      return widget._customValidator?.call(value ?? "");
    }
  }
}
