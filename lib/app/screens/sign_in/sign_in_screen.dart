import 'package:Perso/app/models/account_type.dart';
import 'package:Perso/app/utils/colors.dart';
import 'package:Perso/app/utils/dimens.dart';
import 'package:Perso/app/utils/theme_text.dart';
import 'package:Perso/app/widgets/perso_button.dart';
import 'package:Perso/app/widgets/perso_divider.dart';
import 'package:Perso/app/widgets/perso_login_button.dart';
import 'package:Perso/app/widgets/perso_text_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: PersoColors.lightBlue,
      body: SingleChildScrollView(
        child: Column(
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
                margin: const EdgeInsets.only(
                    top: Dimens.biggerMargin,
                    left: Dimens.normalMargin,
                    right: Dimens.normalMargin),
                child: const PersoTextField(title: "Login")),
            Container(
                margin: const EdgeInsets.only(
                    top: Dimens.normalMargin,
                    left: Dimens.normalMargin,
                    right: Dimens.normalMargin),
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
                    const Expanded(child: PersoDivider()),
                    Text("OR", style: ThemeText.footnoteRegularGrey),
                    const Expanded(child: PersoDivider()),
                  ]),
            ),
            Container(
                margin: const EdgeInsets.only(
                    top: Dimens.biggerMargin,
                    left: Dimens.bigMargin,
                    right: Dimens.bigMargin),
                child: GestureDetector(
                  onTap: () {
                    context.pushNamed("sign_up", extra: AccountType.client);
                  },
                  child: const AbsorbPointer(
                    child:
                        PersoRegisterButton(registerType: AccountType.client),
                  ),
                )),
            Container(
                margin: const EdgeInsets.only(
                    top: Dimens.normalMargin,
                    left: Dimens.bigMargin,
                    right: Dimens.bigMargin),
                child: GestureDetector(
                  onTap: () {
                    context.pushNamed("sign_up", extra: AccountType.trainer);
                  },
                  child: const AbsorbPointer(
                    child:
                        PersoRegisterButton(registerType: AccountType.trainer),
                  ),
                )),
          ],
        ),
      ),
    ));
  }
}
