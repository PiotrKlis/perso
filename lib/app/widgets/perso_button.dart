import 'package:Perso/app/utils/dimens.dart';
import 'package:Perso/app/utils/theme_text.dart';
import 'package:flutter/material.dart';

class PersoButton extends StatelessWidget {
  const PersoButton(
      {super.key,
      required this.title,
      this.width = Dimens.bigButtonWidth,
      this.onTap});

  final String title;
  final double width;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: Dimens.buttonHeight,
        decoration: const BoxDecoration(
            borderRadius:
                BorderRadius.all(Radius.circular(Dimens.buttonBorderRadius))),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(), backgroundColor: Colors.black),
            onPressed: () {
              onTap?.call();
            },
            child: Text(
              title,
              style: ThemeText.calloutBoldWhiteText,
            )));
  }
}
