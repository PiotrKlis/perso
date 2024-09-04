import 'package:flutter/material.dart';
import 'package:perso/app/models/account_type.dart';
import 'package:perso/app/styleguide/styleguide.dart';

class PersoRegisterButton extends StatelessWidget {
  const PersoRegisterButton({
    super.key,
    AccountType registerType = AccountType.client,
  }) : _registerType = registerType;

  final AccountType _registerType;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Dimens.loginButtonHeight,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: PersoColors.lightWhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimens.buttonBorderRadius),
          ),
        ),
        onPressed: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // getIcon(_registerType),
            getTitle(_registerType),
            // Container(
            //     margin: const EdgeInsets.only(left: Dimens.normalMargin),
            //     child: getIcon(_registerType)),
          ],
        ),
      ),
    );
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
        return const Text('Sign Up', style: ThemeText.bodyBoldGreyText);
      case AccountType.trainer:
        return const Text('Register', style: ThemeText.bodyBoldGreyText);
    }
  }
}
