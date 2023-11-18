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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(
                  top: Dimens.biggerMargin,
                  left: Dimens.normalMargin,
                  right: Dimens.normalMargin,),
              child: const Center(
                  child: Icon(
                Icons.email,
                size: Dimens.iconSizeLarge,
              ),),
            ),
            Container(
              margin: const EdgeInsets.only(
                  top: Dimens.mediumMargin,
                  left: Dimens.normalMargin,
                  right: Dimens.normalMargin,),
              child: Text(
                context.strings.sign_up_succes_title,
                style: ThemeText.largerTitleBold,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                  top: Dimens.biggerMargin,
                  left: Dimens.normalMargin,
                  right: Dimens.normalMargin,),
              child: Text(
                context.strings.sign_up_succes_body_1,
                style: ThemeText.bodyRegularBlackText,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                  top: Dimens.biggerMargin,
                  left: Dimens.normalMargin,
                  right: Dimens.normalMargin,),
              child: Text(
                context.strings.sign_up_succes_body_2,
                style: ThemeText.bodyRegularBlackText,
              ),
            ),
            Container(
                margin: const EdgeInsets.only(
                    top: Dimens.biggerMargin,
                    left: Dimens.normalMargin,
                    right: Dimens.normalMargin,),
                child: Text(context.strings.sign_up_succes_body_3,
                    style: ThemeText.bodyBoldBlackText,),),
            Container(
                margin: const EdgeInsets.only(
                    top: Dimens.biggerMargin, left: Dimens.normalMargin,),
                child: Center(
                    child: PersoButton(
                  title: context.strings.confirm,
                  onTap: _onConfirm,
                ),),),
          ],
        ),
      ),
    );
  }

  void _onConfirm(BuildContext context) {
    context.pop();
  }
}
