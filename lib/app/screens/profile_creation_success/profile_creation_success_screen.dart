import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:perso/app/styleguide/styleguide.dart';
import 'package:perso/app/widgets/perso_button.dart';
import 'package:perso/core/extensions/context_extensions.dart';
import 'package:perso/core/navigation/screen_navigation_key.dart';

class ProfileCreationSuccessScreen extends StatelessWidget {
  const ProfileCreationSuccessScreen({super.key});

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
              margin: const EdgeInsets.only(top: Dimens.xmMargin),
              child: Text(
                context.strings.succes_message_body_2,
                style: ThemeText.bodyRegularBlackText,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: Dimens.xlMargin),
              child: PersoButton(
                title: context.strings.finish,
                onTap: (context) {
                  context.replaceNamed(ScreenNavigationKey.home);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
