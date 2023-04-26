import 'package:Perso/app/utils/colors.dart';
import 'package:Perso/app/utils/dimens.dart';
import 'package:Perso/app/utils/theme_text.dart';
import 'package:Perso/app/widgets/perso_button.dart';
import 'package:Perso/app/widgets/perso_login_button.dart';
import 'package:Perso/app/widgets/perso_text_field.dart';
import 'package:Perso/core/navigation/screen_navigation_key.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: PersoColors.lightBlue,
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: Dimens.normalMargin),
                      child: const Align(
                        alignment: Alignment.center,
                        child: Text("PERSO LOGO"),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          context.pop();
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.cancel_outlined),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          Center(
            child: Container(
                margin: const EdgeInsets.only(top: Dimens.hugeMargin),
                child: Text("Sign In", style: ThemeText.largerTitleBold)),
          ),
          Container(
              margin: const EdgeInsets.only(top: Dimens.biggerMargin),
              child: const PersoTextField(title: "Login")),
          Container(
              margin: const EdgeInsets.only(top: Dimens.smallMargin),
              child: const PersoTextField(title: "Password")),
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: Dimens.bigMargin),
              child: Text(
                "Forgot password?",
                style: ThemeText.calloutBoldBlueText,
              ),
            ),
          ),
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: Dimens.bigMargin),
              child: const PersoButton(
                width: Dimens.bigButtonWidth,
                title: "Sign In",
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: Dimens.biggerMargin),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: Container(
                    margin: const EdgeInsets.only(
                        left: Dimens.biggerMargin, right: Dimens.normalMargin),
                    child: const Divider(
                      color: PersoColors.lightGrey,
                    ),
                  )),
                  Text("OR", style: ThemeText.footnoteRegularGrey),
                  Expanded(
                      child: Container(
                          margin: const EdgeInsets.only(
                              left: Dimens.normalMargin,
                              right: Dimens.biggerMargin),
                          child: const Divider(color: PersoColors.lightGrey)))
                ]),
          ),
          Container(
              margin: const EdgeInsets.only(
                  top: Dimens.biggerMargin,
                  left: Dimens.bigMargin,
                  right: Dimens.bigMargin),
              child: const Center(
                  child: PersoRegisterButton(registerType: RegisterType.client))),
          Container(
              margin: const EdgeInsets.only(
                  top: Dimens.mediumMargin,
                  left: Dimens.bigMargin,
                  right: Dimens.bigMargin),
              child: const Center(
                  child: PersoRegisterButton(registerType: RegisterType.trainer))),
          Container(
            margin: const EdgeInsets.only(top: Dimens.hugeMargin),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account?",
                  style: ThemeText.footnoteBoldGrey,
                ),
                Container(
                  margin: const EdgeInsets.only(left: Dimens.smallerMargin),
                  child: GestureDetector(
                    onTap: () {
                      context.go(ScreenNavigationKey.signUp);
                    },
                    child: Text(
                      "Sign Up",
                      style: ThemeText.footnoteBoldBlue,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    ));
  }
}
