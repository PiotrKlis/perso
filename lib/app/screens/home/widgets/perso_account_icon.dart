import 'package:flutter/material.dart';
import 'package:perso/app/styleguide/styleguide.dart';

class PersoAccountIcon extends StatelessWidget {
  const PersoAccountIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(
          left: Dimens.mMargin, top: Dimens.mMargin),
      child: const Icon(Icons.account_circle_rounded,
          size: Dimens.accountIconSize, color: Colors.black),
    );
  }
}
