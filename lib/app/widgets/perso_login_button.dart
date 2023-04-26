import 'package:Perso/app/utils/colors.dart';
import 'package:Perso/app/utils/dimens.dart';
import 'package:Perso/app/utils/theme_text.dart';
import 'package:flutter/material.dart';

class PersoRegisterButton extends StatelessWidget {
  const PersoRegisterButton({Key? key, required this.registerType}) : super(key: key);
  final RegisterType registerType;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: Dimens.loginButtonHeight,
        child: ElevatedButton(
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
                getIcon(registerType),
                getTitle(registerType),
              ],
            )));
  }

  Icon getIcon(RegisterType loginType) {
    switch (loginType) {
      case RegisterType.client:
        return const Icon(Icons.fitness_center, color: PersoColors.lightGrey);
      case RegisterType.trainer:
        return const Icon(Icons.work, color: PersoColors.lightGrey);
    }
  }

  Text getTitle(RegisterType loginType) {
    switch (loginType) {
      case RegisterType.client:
        return Text("Register as a Client", style: ThemeText.bodyBoldGreyText);
      case RegisterType.trainer:
        return Text("Register as a Trainer", style: ThemeText.bodyBoldGreyText);
    }
  }
}

enum RegisterType { client, trainer }
