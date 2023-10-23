import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:perso/app/styleguide/styleguide.dart';
import 'package:perso/app/utils/extension/context_extensions.dart';
import 'package:perso/app/widgets/perso_button.dart';
import 'package:perso/core/navigation/screen_navigation_key.dart';

class ProfileCreationSuccessScreen extends StatelessWidget {
  const ProfileCreationSuccessScreen({super.key});

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
                context.strings.succes_message_title,
                style: ThemeText.largeTitleBold,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: Dimens.xlMargin),
              child: Text(
                context.strings.succes_message_body_1,
                style: ThemeText.bodyRegularBlackText,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: Dimens.mMargin),
              child: Text(context.strings.succes_message_body_2,
                  style: ThemeText.bodyRegularBlackText),
            ),
            Container(
              margin: const EdgeInsets.only(top: Dimens.substantialMargin),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PersoButton(
                    title: context.strings.finish,
                    onTap: (context) {
                      context.replaceNamed(ScreenNavigationKey.home);
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
}
