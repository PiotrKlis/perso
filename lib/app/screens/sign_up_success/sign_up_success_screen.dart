import 'package:Perso/app/utils/colors.dart';
import 'package:Perso/app/utils/dimens.dart';
import 'package:Perso/app/utils/theme_text.dart';
import 'package:Perso/app/widgets/perso_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
                "Thank you for registering!",
                style: ThemeText.largerTitleBold,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                  top: Dimens.biggerMargin,
                  left: Dimens.normalMargin,
                  right: Dimens.normalMargin),
              child: Text(
                "Please check you email to confirm your account.",
                style: ThemeText.bodyRegularBlackText,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                  top: Dimens.biggerMargin,
                  left: Dimens.normalMargin,
                  right: Dimens.normalMargin),
              child: Text(
                "If you don't receive any email, please check your spam folder.",
                style: ThemeText.bodyRegularBlackText,
              ),
            ),
            Container(
                margin: const EdgeInsets.only(
                    top: Dimens.biggerMargin,
                    left: Dimens.normalMargin,
                    right: Dimens.normalMargin),
                child:
                    Text("See you soon!", style: ThemeText.bodyBoldBlackText)),
            Container(
                margin: const EdgeInsets.only(
                    top: Dimens.biggerMargin, left: Dimens.normalMargin),
                child: Center(
                    child: PersoButton(
                  title: "Confirm",
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
