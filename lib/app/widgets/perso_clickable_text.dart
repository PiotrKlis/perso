import 'package:perso/app/styleguide/value/app_typography.dart';
import 'package:flutter/material.dart';

class PersoClickableText extends StatelessWidget {
  const PersoClickableText({required this.title, super.key});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(title, style: ThemeText.bodyRegularBlue);
  }
}
