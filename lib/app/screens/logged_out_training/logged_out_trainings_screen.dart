import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:perso/app/styleguide/value/app_dimens.dart';
import 'package:perso/app/styleguide/value/app_typography.dart';
import 'package:perso/app/utils/extension/context_extensions.dart';
import 'package:perso/app/widgets/perso_button.dart';
import 'package:perso/core/navigation/screen_navigation_key.dart';

class LoggedOutTrainingScreen extends StatelessWidget {
  const LoggedOutTrainingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Column(
        children: [
          _Image(),
          _Title(),
          _Subtitle(),
          _ConfirmButton(),
        ],
      ),
    );
  }
}

class _ConfirmButton extends StatelessWidget {
  const _ConfirmButton();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: const EdgeInsets.only(
            bottom: Dimens.xxxlMargin,
            left: Dimens.xlMargin,
            right: Dimens.xlMargin,
          ),
          child: PersoButton(
            onTap: (context) {
              context.pushNamed(ScreenNavigationKey.signIn);
            },
            title: context.strings.sign_in,
          ),
        ),
      ),
    );
  }
}

class _Subtitle extends StatelessWidget {
  const _Subtitle();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: Dimens.xmMargin,
        top: Dimens.lMargin,
      ),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Text(
          'Your dream is one step away...',
          style: ThemeText.mediumTitleRegular,
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: Dimens.xmMargin,
        top: Dimens.lMargin,
        right: Dimens.xmMargin,
      ),
      child: Text(
        'Find the best trainers and your ideal personal plan',
        style: ThemeText.largeTitleBold,
      ),
    );
  }
}

class _Image extends StatelessWidget {
  const _Image();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: Dimens.xxxlMargin,
        left: Dimens.xmMargin,
        right: Dimens.xmMargin,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Dimens.buttonBorderRadius),
        child: const Image(
          image: AssetImage('assets/images/trainings_logged_out.png'),
        ),
      ),
    );
  }
}
