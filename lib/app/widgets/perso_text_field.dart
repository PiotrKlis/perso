import 'package:Perso/app/utils/dimens.dart';
import 'package:Perso/app/utils/theme_text.dart';
import 'package:flutter/material.dart';
// import 'package:form_field_validator/form_field_validator.dart';

class PersoTextField extends StatelessWidget {
  const PersoTextField({Key? key, required this.title, required this.isRequired}) : super(key: key);
  final String title;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimens.textFieldHeight,
      margin: const EdgeInsets.only(
          left: Dimens.biggerMargin, right: Dimens.biggerMargin),
      child: TextFormField(
        // validator: RequiredValidator(
        //       errorText: "Field is required");
        // },
        textAlign: TextAlign.center,
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.zero,
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
