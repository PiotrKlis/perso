import 'package:Perso/app/utils/colors.dart';
import 'package:Perso/app/utils/dimens.dart';
import 'package:Perso/app/utils/theme_text.dart';
import 'package:Perso/app/widgets/perso_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignUpSuccessScreen extends StatelessWidget {
  const SignUpSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: PersoColors.lightBlue,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(
                  top: Dimens.biggerMargin,
                  left: Dimens.normalMargin,
                  right: Dimens.normalMargin),
              child: const Center(child: Icon(Icons.email, size: 160)),
            ),
            Container(
              margin: const EdgeInsets.only(
                  top: Dimens.mediumMargin,
                  left: Dimens.normalMargin,
                  right: Dimens.normalMargin),
              child: Text(
                AppLocalizations.of(context)!.sign_up_succes_title,
                style: ThemeText.largerTitleBold,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                  top: Dimens.biggerMargin,
                  left: Dimens.normalMargin,
                  right: Dimens.normalMargin),
              child: Text(
                AppLocalizations.of(context)!.sign_up_succes_body_1,
                style: ThemeText.bodyRegularBlackText,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                  top: Dimens.biggerMargin,
                  left: Dimens.normalMargin,
                  right: Dimens.normalMargin),
              child: Text(
                AppLocalizations.of(context)!.sign_up_succes_body_2,
                style: ThemeText.bodyRegularBlackText,
              ),
            ),
            Container(
                margin: const EdgeInsets.only(
                    top: Dimens.biggerMargin,
                    left: Dimens.normalMargin,
                    right: Dimens.normalMargin),
                child:
                    Text(AppLocalizations.of(context)!.sign_up_succes_body_3, style: ThemeText.bodyBoldBlackText)),
            Container(
                margin: const EdgeInsets.only(
                    top: Dimens.biggerMargin, left: Dimens.normalMargin),
                child: Center(
                    child: PersoButton(
                  title: AppLocalizations.of(context)!.confirm,
                  onTap: _onConfirm,
                )))
          ],
        ),
      ),
    );
  }

  void _onConfirm(BuildContext context) {
    context.pop();
  }
}
