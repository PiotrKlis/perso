import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:perso/app/styleguide/styleguide.dart';
import 'package:perso/app/utils/extension/context_extensions.dart';
import 'package:perso/app/widgets/perso_button.dart';
import 'package:perso/core/navigation/screen_navigation_key.dart';
import 'package:perso/core/models/user_type.dart';

class ProfileCreationScreen extends StatelessWidget {
  const ProfileCreationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(
          left: Dimens.xmMargin,
          right: Dimens.xmMargin,
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: Dimens.xxxlMargin),
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
              margin: const EdgeInsets.only(top: Dimens.xmMargin),
              child: Text(
                context.strings.welcome_message_body_2,
                style: ThemeText.bodyRegularBlackText,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                top: Dimens.xxxlMargin,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: Dimens.sMargin,
                    ),
                    child: PersoButton(
                      width: Dimens.bigButtonWidth,
                      title: context.strings.choose_trainer_user_type,
                      whiteBlackTheme: true,
                      onTap: _navigateTrainer,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: Dimens.sMargin,
                    ),
                    child: PersoButton(
                      width: Dimens.bigButtonWidth,
                      title: context.strings.choose_client_user_type,
                      onTap: _navigateClient,
                    ),
                  ),
                ],
              ),
            ),
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
