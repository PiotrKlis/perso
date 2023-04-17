import 'package:Perso/app/utils/colors.dart';
import 'package:Perso/app/utils/dimens.dart';
import 'package:Perso/app/utils/theme_text.dart';
import 'package:flutter/material.dart';

class PersoLoginButton extends StatelessWidget {
  const PersoLoginButton({Key? key, required this.loginType}) : super(key: key);
  final LoginType loginType;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: Dimens.loginButtonHeight, child: getButton(loginType));
  }

  ElevatedButton getButton(LoginType loginType) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: PersoColors.lightWhite,
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(Dimens.buttonBorderRadius))),
        onPressed: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            getIcon(loginType),
            getTitle(loginType),
          ],
        ));
  }

  Icon getIcon(LoginType loginType) {
    switch (loginType) {
      case LoginType.google:
        return const Icon(Icons.g_mobiledata, color: PersoColors.lightGrey);
      case LoginType.apple:
        return const Icon(Icons.apple, color: PersoColors.lightGrey);
    }
  }

  Text getTitle(LoginType loginType) {
    switch (loginType) {
      case LoginType.google:
        return Text("Sign in with Google", style: ThemeText.bodyBoldGreyText);
      case LoginType.apple:
        return Text("Sign in with Apple", style: ThemeText.bodyBoldGreyText);
    }
  }
}

enum LoginType { google, apple }
