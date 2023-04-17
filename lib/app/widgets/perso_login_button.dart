import 'package:Perso/app/utils/colors.dart';
import 'package:Perso/app/utils/dimens.dart';
import 'package:Perso/app/utils/theme_text.dart';
import 'package:flutter/material.dart';

class PersoLoginButton extends StatelessWidget {
  const PersoLoginButton({Key? key, required this.loginType}) : super(key: key);
  final LoginType loginType;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: Dimens.loginButtonHeight,
        decoration: const BoxDecoration(
            color: PersoColors.lightWhite,
            borderRadius:
                BorderRadius.all(Radius.circular(Dimens.buttonBorderRadius))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.g_mobiledata, color: PersoColors.lightGrey),
            Text("Sign in with Google", style: ThemeText.bodyBoldGreyText,)
          ],
        ));
  }
}

enum LoginType { Google, Facebook, Apple }
