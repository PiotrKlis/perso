import 'package:Perso/app/utils/dimens.dart';
import 'package:Perso/app/utils/theme_text.dart';
import 'package:Perso/app/widgets/perso_button.dart';
import 'package:Perso/core/navigation/screen_navigation_key.dart';
import 'package:Perso/core/user_type.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileCreationScreen extends StatelessWidget {
  const ProfileCreationScreen({super.key});

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
              child: Text (AppLocalizations.of(context)!.welcome_message_title,
                
                style: ThemeText.largeTitleBold,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: Dimens.biggerMargin),
              child: Text(AppLocalizations.of(context)!.welcome_message_body_1,
                
                style: ThemeText.bodyRegularBlackText,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: Dimens.normalMargin),
              child: Text(AppLocalizations.of(context)!.welcome_message_body_2,
                  
                  style: ThemeText.bodyRegularBlackText),
            ),
            Container(
              margin: const EdgeInsets.only(top: Dimens.substantialMargin),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PersoButton(
                      title: AppLocalizations.of(context)!.choose_trainer_user_type,
                      whiteBlackTheme: true,
                      onTap: _navigateTrainer),
                  Container(
                    margin: const EdgeInsets.only(left: Dimens.normalMargin),
                    child: PersoButton(
                      title: AppLocalizations.of(context)!.choose_client_user_type,
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
    context.pushNamed(ScreenNavigationKey.profileEdit,
        extra: UserType.client);
  }

  void _navigateTrainer(BuildContext context) {
    context.pushNamed(ScreenNavigationKey.profileEdit,
        extra: UserType.trainer);
  }
}
