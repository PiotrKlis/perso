import 'dart:async';

import 'package:flutter/material.dart';
import 'package:perso/app/styleguide/value/app_colors.dart';
import 'package:perso/app/styleguide/value/app_typography.dart';

class PersoAsyncTextFormField extends StatefulWidget {

  const PersoAsyncTextFormField(
      {required this.validator, required this.validationDebounce, required this.controller, super.key,
      this.hintText = '',});
  final Future<bool> Function(String) validator;
  final Duration validationDebounce;
  final TextEditingController controller;
  final String hintText;

  @override
  _PersoAsyncTextFormFieldState createState() =>
      _PersoAsyncTextFormFieldState();
}

class _PersoAsyncTextFormFieldState extends State<PersoAsyncTextFormField> {
  Timer? _debounce;
  bool isValid = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value?.isEmpty ?? false) {
          return 'Required Field';
        } else if (!isValid) {
          return 'This nickname is already taken';
        } else {
          return null;
        }
      },
      onChanged: (text) async {
        if (text.isEmpty) {
          cancelTimer();
          return;
        }
        _debounce = Timer(widget.validationDebounce, () async {
          isValid = await validate(text);
        });
      },
      controller: widget.controller,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          errorMaxLines: 2,
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 0.5, color: PersoColors.lightGrey),),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 0.5, color: PersoColors.lightGrey),
          ),
          labelText: widget.hintText,
          labelStyle: ThemeText.bodyRegularGreyText,),
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
    return await widget.validator(text);
  }
}
