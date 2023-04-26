import 'package:Perso/app/utils/colors.dart';
import 'package:Perso/app/utils/dimens.dart';
import 'package:Perso/app/widgets/perso_button.dart';
import 'package:Perso/app/widgets/perso_login_button.dart';
import 'package:Perso/app/widgets/perso_text_field.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text('Sign Up'),
      ),
      body: Container(
          color: PersoColors.lightBlue,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                  margin: EdgeInsets.only(top: Dimens.hugeMargin),
                  child: Icon(
                    Icons.photo,
                    size: 96.0,
                  )),
              Container(
                  margin: EdgeInsets.only(top: Dimens.mediumMargin),
                  child: PersoTextField(title: "Name")),
              Container(
                  margin: EdgeInsets.only(top: Dimens.mediumMargin),
                  child: PersoTextField(title: "Surname")),
              Container(
                  margin: EdgeInsets.only(top: Dimens.mediumMargin),
                  child: PersoTextField(title: "Nickname")),
              Container(
                  margin: EdgeInsets.only(top: Dimens.mediumMargin),
                  child: PersoTextField(title: "Email")),
              Container(
                  margin: EdgeInsets.only(top: Dimens.mediumMargin),
                  child: PersoTextField(title: "Passowrd")),
              Container(
                  margin: EdgeInsets.only(top: Dimens.normalMargin),
                  child: PersoButton(width: 160.0, title: "Register"))
            ],
          )),
    );
  }
}
