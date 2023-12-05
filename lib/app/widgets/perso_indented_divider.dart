import 'package:flutter/material.dart';
import 'package:perso/app/styleguide/styleguide.dart';

class PersoIndentedDivider extends StatelessWidget {
  const PersoIndentedDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
          left: Dimens.xlMargin, right: Dimens.xmMargin,),
      child: const Divider(
        height: 1,
        color: PersoColors.lightGrey,
      ),
    );
  }
}
