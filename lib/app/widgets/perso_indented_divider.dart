import 'package:Perso/app/utils/colors.dart';
import 'package:Perso/app/utils/dimens.dart';
import 'package:flutter/material.dart';

class PersoIndentedDivider extends StatelessWidget {
  const PersoIndentedDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
          left: Dimens.biggerMargin, right: Dimens.normalMargin),
      child: const Divider(
        height: 1,
        color: PersoColors.lightGrey,
      ),
    );
  }
}
