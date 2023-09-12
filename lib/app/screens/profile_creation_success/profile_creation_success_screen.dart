import 'package:Perso/app/utils/dimens.dart';
import 'package:Perso/app/utils/theme_text.dart';
import 'package:Perso/app/widgets/perso_button.dart';
import 'package:Perso/core/navigation/screen_navigation_key.dart';
import 'package:Perso/data/shared_prefs/perso_shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class ProfileCreationSuccessScreen extends StatelessWidget {
  const ProfileCreationSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(
            left: Dimens.normalMargin, right: Dimens.normalMargin),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: Dimens.substantialMargin),
              child: Text(
                "Amazing success!",
                style: ThemeText.largeTitleBold,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: Dimens.biggerMargin),
              child: Text(
                "Your account creation has been completed. Now you can enjoy all the benefits of being a member.",
                style: ThemeText.bodyRegularBlackText,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: Dimens.normalMargin),
              child: Text(
                  "If you have any questions or need assistance, don't hesitate to reach out to our support team. We hope you have a fantastic time using our app!",
                  style: ThemeText.bodyRegularBlackText),
            ),
            Container(
              margin: const EdgeInsets.only(top: Dimens.substantialMargin),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PersoButton(
                    title: "FINISH",
                    onTap: (context) {
                      //TODO: Move setting isProfileCreatedKey to bloc layer
                      PersoSharedPrefs prefs = GetIt.instance.get<PersoSharedPrefs>();
                      prefs.setBool(PersoSharedPrefs.isProfileCreatedKey, true);
                      _navigateHome(context);
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _navigateHome(BuildContext context) {
    context.replaceNamed(ScreenNavigationKey.home);
  }
}
