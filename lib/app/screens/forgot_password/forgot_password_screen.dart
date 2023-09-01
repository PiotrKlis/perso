import 'package:Perso/app/utils/colors.dart';
import 'package:Perso/app/utils/dimens.dart';
import 'package:Perso/app/utils/theme_text.dart';
import 'package:Perso/app/widgets/perso_button.dart';
import 'package:Perso/app/widgets/perso_text_field.dart';
import 'package:flutter/material.dart';

class PasswordRecoveryScreen extends StatelessWidget {
  const PasswordRecoveryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PersoColors.lightBlue,
      appBar: AppBar(

        title: const Text('Password recovery'),
      ),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Container(
          margin: const EdgeInsets.all(Dimens.normalMargin),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  margin: const EdgeInsets.only(top: Dimens.hugeMargin),
                  child: const Icon(Icons.lock, size: 160.0, color: Colors.black)),
              Container(
                  margin: const EdgeInsets.only(top: Dimens.biggerMargin),
                  child: Text("Forgotten password?",
                      style: ThemeText.largeTitleBold)),
              Container(
                margin: const EdgeInsets.only(top: Dimens.biggerMargin),
                child: Text("No worries, we've got you covered",
                    style: ThemeText.bodyBoldBlackText),
              ),
              Container(
                margin: const EdgeInsets.only(top: Dimens.smallerMargin),
                child: Text(
                  'Enter your email address to reset your password',
                  style: ThemeText.bodyRegularBlackText,
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(top: Dimens.normalMargin),
                  child: const PersoTextField(title: "Email")),
              Container(
                margin: const EdgeInsets.only(top: Dimens.biggerMargin),
                child: PersoButton(
                  title: "Reset Password",
                  onTap: (context) {

                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
