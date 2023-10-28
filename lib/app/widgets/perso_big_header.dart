import 'package:perso/app/styleguide/value/app_typography.dart';
import 'package:flutter/material.dart';

class PersoBigHeader extends StatelessWidget {
  const PersoBigHeader({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(title, style: ThemeText.largerTitleBold);
  }
}
