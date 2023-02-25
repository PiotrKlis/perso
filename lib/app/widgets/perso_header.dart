import 'package:Perso/app/utils/theme_text.dart';
import 'package:flutter/material.dart';

class PersoHeader extends StatelessWidget {
  const PersoHeader({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(title, style: ThemeText.mediumTitleBold);
  }
}
