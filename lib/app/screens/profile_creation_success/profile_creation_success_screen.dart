import 'package:Perso/app/utils/dimens.dart';
import 'package:Perso/app/utils/theme_text.dart';
import 'package:Perso/app/widgets/perso_button.dart';
import 'package:Perso/core/dependency_injection/get_it_config.dart';
import 'package:Perso/core/navigation/screen_navigation_key.dart';
import 'package:Perso/data/shared_prefs/perso_shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
              child: Text(AppLocalizations.of(context)!.amazing_success,
                
                style: ThemeText.largeTitleBold,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: Dimens.biggerMargin),
              child: Text(AppLocalizations.of(context)!.account_creation_completed,
                
                style: ThemeText.bodyRegularBlackText,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: Dimens.normalMargin),
              child: Text(AppLocalizations.of(context)!.questions_or_need_assistance,
                  
                  style: ThemeText.bodyRegularBlackText),
            ),
            Container(
              margin: const EdgeInsets.only(top: Dimens.substantialMargin),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PersoButton(
                    title: AppLocalizations.of(context)!.finish,
                    onTap: (context) {
                      //TODO: Move setting isProfileCreatedKey to bloc layer
                      PersoSharedPrefs prefs = getIt.get<PersoSharedPrefs>();
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
