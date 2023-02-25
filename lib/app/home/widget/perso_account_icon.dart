import 'package:Perso/app/utils/dimens.dart';
import 'package:flutter/material.dart';

class PersoAccountIcon extends StatelessWidget {
  const PersoAccountIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Icon(
        Icons.account_circle_rounded,
        size: Dimens.accountIconSize,
        color: Colors.black);
  }
}
