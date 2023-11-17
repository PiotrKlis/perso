import 'package:flutter/material.dart';
import 'package:perso/app/styleguide/value/app_dimens.dart';
import 'package:perso/app/styleguide/value/app_typography.dart';

class PersoButton extends StatelessWidget {
  const PersoButton(
      {super.key,
      this.title = '',
      this.width = Dimens.bigButtonWidth,
      this.whiteBlackTheme = false,
      this.isLoading = false,
      this.onTap});

  final String title;
  final double width;
  final void Function(BuildContext context)? onTap;
  final bool whiteBlackTheme;
  final bool isLoading;

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
                shape: const StadiumBorder(),
                backgroundColor: whiteBlackTheme ? Colors.white : Colors.black),
            onPressed: () {
              onTap?.call(context);
            },
            child: _getContent()));
  }

  Widget _getContent() {
    if (isLoading) {
      return const CircularProgressIndicator();
    } else {
      return Text(
        title,
        style: whiteBlackTheme
            ? ThemeText.calloutBoldBlackText
            : ThemeText.calloutBoldWhiteText,
      );
    }
  }
}
