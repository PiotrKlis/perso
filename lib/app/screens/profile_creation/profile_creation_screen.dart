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
              child: Text (AppLocalizations.of(context)!.welcome_message,
                
                style: ThemeText.largeTitleBold,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: Dimens.biggerMargin),
              child: Text(AppLocalizations.of(context)!.thank_you_for_logging,
                
                style: ThemeText.bodyRegularBlackText,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: Dimens.normalMargin),
              child: Text(AppLocalizations.of(context)!.get_ready_to_embark,
                  
                  style: ThemeText.bodyRegularBlackText),
            ),
            Container(
              margin: const EdgeInsets.only(top: Dimens.substantialMargin),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PersoButton(
                      title: AppLocalizations.of(context)!.i_am_a_trainer,
                      whiteBlackTheme: true,
                      onTap: _navigateTrainer),
                  Container(
                    margin: const EdgeInsets.only(left: Dimens.normalMargin),
                    child: PersoButton(
                      title: AppLocalizations.of(context)!.i_am_a_client,
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
