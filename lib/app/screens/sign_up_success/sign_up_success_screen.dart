import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:perso/app/styleguide/styleguide.dart';
import 'package:perso/app/utils/extension/context_extensions.dart';
import 'package:perso/app/widgets/perso_button.dart';

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
                  top: Dimens.xlMargin,
                  left: Dimens.mMargin,
                  right: Dimens.mMargin),
              child: const Center(
                  child: Icon(
                Icons.email,
                size: Dimens.iconSizeLarge,
              )),
            ),
            Container(
              margin: const EdgeInsets.only(
                  top: Dimens.sMargin,
                  left: Dimens.mMargin,
                  right: Dimens.mMargin),
              child: Text(
                context.strings.sign_up_succes_title,
                style: ThemeText.largerTitleBold,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                  top: Dimens.xlMargin,
                  left: Dimens.mMargin,
                  right: Dimens.mMargin),
              child: Text(
                context.strings.sign_up_succes_body_1,
                style: ThemeText.bodyRegularBlackText,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                  top: Dimens.xlMargin,
                  left: Dimens.mMargin,
                  right: Dimens.mMargin),
              child: Text(
                context.strings.sign_up_succes_body_2,
                style: ThemeText.bodyRegularBlackText,
              ),
            ),
            Container(
                margin: const EdgeInsets.only(
                    top: Dimens.xlMargin,
                    left: Dimens.mMargin,
                    right: Dimens.mMargin),
                child: Text(context.strings.sign_up_succes_body_3,
                    style: ThemeText.bodyBoldBlackText)),
            Container(
                margin: const EdgeInsets.only(
                    top: Dimens.xlMargin, left: Dimens.mMargin),
                child: Center(
                    child: PersoButton(
                  title: context.strings.confirm,
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
