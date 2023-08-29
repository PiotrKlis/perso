import 'package:Perso/app/utils/dimens.dart';
import 'package:Perso/app/utils/theme_text.dart';
import 'package:Perso/app/widgets/perso_button.dart';
import 'package:Perso/core/navigation/screen_navigation_key.dart';
import 'package:Perso/core/user_type.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileCreationScreen extends StatelessWidget {
  const ProfileCreationScreen({super.key});

  //TODO: It should not be possible to leave this screen.
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
                "Welcome to PERSO!",
                style: ThemeText.largeTitleBold,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: Dimens.biggerMargin),
              child: Text(
                "Thank you for logging in. We're thrilled to have you join our community 🎉",
                style: ThemeText.bodyRegularBlackText,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: Dimens.normalMargin),
              child: Text(
                  "Get ready to embark on a journey of discovery and innovation",
                  style: ThemeText.bodyRegularBlackText),
            ),
            Container(
              margin: const EdgeInsets.only(top: Dimens.substantialMargin),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PersoButton(
                      title: "I am a trainer",
                      whiteBlackTheme: true,
                      onTap: _navigateTrainer),
                  PersoButton(
                    title: "I am a client",
                    onTap: _navigateClient,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _navigateClient(BuildContext context) {
    context.replaceNamed(ScreenNavigationKey.profileEdit, extra: UserType.client);
  }

  void _navigateTrainer(BuildContext context) {
    context.replaceNamed(ScreenNavigationKey.profileEdit, extra: UserType.trainer);
  }
}
