import 'package:Perso/app/models/account_type.dart';
import 'package:Perso/app/utils/colors.dart';
import 'package:Perso/app/utils/dimens.dart';
import 'package:Perso/app/utils/theme_text.dart';
import 'package:flutter/material.dart';

class PersoRegisterButton extends StatelessWidget {
  const PersoRegisterButton({Key? key, required this.registerType}) : super(key: key);
  final AccountType registerType;

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
                Container(margin: const EdgeInsets.only(left: Dimens.normalMargin), child: getTitle(registerType)),
                Container(margin: const EdgeInsets.only(left: Dimens.normalMargin), child: getIcon(registerType)),
              ],
            )));
  }

  Icon getIcon(AccountType loginType) {
    switch (loginType) {
      case AccountType.client:
        return const Icon(Icons.fitness_center, color: PersoColors.lightGrey);
      case AccountType.trainer:
        return const Icon(Icons.work, color: PersoColors.lightGrey);
    }
  }

  Text getTitle(AccountType loginType) {
    switch (loginType) {
      case AccountType.client:
        return Text("Register as a Client", style: ThemeText.bodyBoldGreyText);
      case AccountType.trainer:
        return Text("Register as a Trainer", style: ThemeText.bodyBoldGreyText);
    }
  }
}
