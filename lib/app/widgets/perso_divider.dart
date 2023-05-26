import 'package:Perso/app/utils/colors.dart';
import 'package:Perso/app/utils/dimens.dart';
import 'package:flutter/material.dart';

class PersoDivider extends StatelessWidget {
  const PersoDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
      left: Dimens.biggerMargin, right: Dimens.normalMargin),
      child: const Divider(
    color: PersoColors.lightGrey,
      ),
    );
  }
}
