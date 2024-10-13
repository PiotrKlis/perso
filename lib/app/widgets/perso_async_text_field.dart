import 'dart:async';

import 'package:flutter/material.dart';
import 'package:perso/app/styleguide/value/app_colors.dart';
import 'package:perso/app/styleguide/value/app_typography.dart';
import 'package:perso/core/dependency_injection/get_it.dart';
import 'package:perso/core/providers/string_provider.dart';

class PersoAsyncTextFormField extends StatefulWidget {
  const PersoAsyncTextFormField({
    required Future<bool> Function(String) validator,
    required Duration validationDebounce,
    required TextEditingController controller,
    super.key,
    String hintText = '',
    int maxLength = 60,
    bool isReadOnly = false,
  })  : _validationDebounce = validationDebounce,
        _validator = validator,
        _controller = controller,
        _hintText = hintText,
        _isReadOnly = isReadOnly,
        _maxLength = maxLength;

  final Future<bool> Function(String) _validator;
  final Duration _validationDebounce;
  final TextEditingController _controller;
  final String _hintText;
  final int _maxLength;
  final bool _isReadOnly;

  @override
  _PersoAsyncTextFormFieldState createState() =>
      _PersoAsyncTextFormFieldState();
}

class _PersoAsyncTextFormFieldState extends State<PersoAsyncTextFormField> {
  Timer? _debounce;
  bool isValid = true;
  static final stringProvider = getIt.get<StringProvider>();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: widget._isReadOnly,
      validator: (value) {
        if (value?.isEmpty ?? false) {
          return stringProvider.strings.required_field;
        } else if (!isValid) {
          return stringProvider.strings.nickname_already_taken;
        } else {
          return null;
        }
      },
      onChanged: (text) async {
        if (text.isEmpty) {
          cancelTimer();
          return;
        }
        _debounce = Timer(widget._validationDebounce, () async {
          isValid = await validate(text);
        });
      },
      controller: widget._controller,
      textInputAction: TextInputAction.next,
      maxLength: widget._maxLength,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        errorMaxLines: 2,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 0.5, color: PersoColors.lightGrey),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 0.5, color: PersoColors.lightGrey),
        ),
        labelText: widget._hintText,
        labelStyle: ThemeText.bodyRegularGreyText,
      ),
    );
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void cancelTimer() {
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }
  }

  Future<bool> validate(String text) async {
    return widget._validator(text);
  }
}
