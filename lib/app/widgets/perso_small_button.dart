import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:perso/app/styleguide/styleguide.dart';

class PersoLanguageButton extends StatelessWidget {
  const PersoLanguageButton({
    required this.text,
    required this.addLanguage,
    required this.customValidator,
    super.key,
  });

  final String text;
  final void Function(String value) addLanguage;
  final String? Function() customValidator;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 170,
      child: TextFormField(
        validator: (_) => customValidator.call(),
        readOnly: true,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.zero,
          prefixIcon: const Icon(Icons.add),
          prefixIconColor: PersoColors.blue,
          filled: true,
          fillColor: Colors.white,
          hintText: text,
          hintStyle: ThemeText.bodyRegularBlue,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimens.buttonBorderRadius),
            borderSide: BorderSide.none,
          ),
        ),
        onTap: () {
          showCountryPicker(
            onClosed: () {},
            useSafeArea: true,
            favorite: ['PL', 'GB', 'UA'],
            context: context,
            onSelect: (value) {
              final emoji = value.flagEmoji;
              addLanguage.call(emoji);
            },
          );
        },
      ),
    );
  }
}
