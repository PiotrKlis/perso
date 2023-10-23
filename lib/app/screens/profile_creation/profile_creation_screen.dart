import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:perso/app/styleguide/styleguide.dart';
import 'package:perso/app/utils/extension/context_extensions.dart';
import 'package:perso/app/widgets/perso_button.dart';
import 'package:perso/core/navigation/screen_navigation_key.dart';
import 'package:perso/core/user_type.dart';

class ProfileCreationScreen extends StatelessWidget {
  const ProfileCreationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(
            left: Dimens.mMargin, right: Dimens.mMargin),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: Dimens.substantialMargin),
              child: Text(
                context.strings.welcome_message_title,
                style: ThemeText.largeTitleBold,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: Dimens.xlMargin),
              child: Text(
                context.strings.welcome_message_body_1,
                style: ThemeText.bodyRegularBlackText,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: Dimens.mMargin),
              child: Text(context.strings.welcome_message_body_2,
                  style: ThemeText.bodyRegularBlackText),
            ),
            Container(
              margin: const EdgeInsets.only(top: Dimens.substantialMargin),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PersoButton(
                      title: context.strings.choose_trainer_user_type,
                      whiteBlackTheme: true,
                      onTap: _navigateTrainer),
                  Container(
                    margin: const EdgeInsets.only(left: Dimens.mMargin),
                    child: PersoButton(
                      title: context.strings.choose_client_user_type,
                      onTap: _navigateClient,
                    ),
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
    context.pushNamed(ScreenNavigationKey.profileEdit, extra: UserType.client);
  }

  void _navigateTrainer(BuildContext context) {
    context.pushNamed(ScreenNavigationKey.profileEdit, extra: UserType.trainer);
  }
}
