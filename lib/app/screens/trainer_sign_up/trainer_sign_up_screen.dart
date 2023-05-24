import 'package:Perso/app/utils/colors.dart';
import 'package:Perso/app/utils/dimens.dart';
import 'package:Perso/app/widgets/perso_button.dart';
import 'package:Perso/app/widgets/perso_text_field.dart';
import 'package:flutter/material.dart';

import '../../utils/validators.dart';

class TrainerSignUpScreen extends StatefulWidget {
  const TrainerSignUpScreen({Key? key}) : super(key: key);

  @override
  State<TrainerSignUpScreen> createState() => _TrainerSignUpScreenState();
}

class _TrainerSignUpScreenState extends State<TrainerSignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PersoColors.lightBlue,
      appBar: AppBar(
        elevation: 0.0,
        title: const Text('Sign Up'),
      ),
      body: SingleChildScrollView(
        // https://github.com/NetFreaker/Medium/blob/main/multi_form_validation/lib/main.dart
        // Create own validators
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                  margin: const EdgeInsets.only(top: Dimens.hugeMargin),
                  child: const Icon(
                    Icons.photo,
                    size: 96.0,
                  )),
              Container(
                  margin: const EdgeInsets.only(top: Dimens.bigMargin),
                  child: const PersoTextField(title: "Email", customValidator: TextFieldValidator.validateEmail)),
              Container(
                  margin: const EdgeInsets.only(top: Dimens.normalMargin),
                  child: const PersoTextField(title: "Password", customValidator: TextFieldValidator.validatePassword)),
              Container(
                  margin: const EdgeInsets.only(top: Dimens.normalMargin),
                  child: const PersoTextField(
                      title: "Name", customValidator: TextFieldValidator.validateName)),
              Container(
                  margin: const EdgeInsets.only(top: Dimens.normalMargin),
                  child: const PersoTextField(title: "Surname", customValidator: TextFieldValidator.validateName)),
              Container(
                  margin: const EdgeInsets.only(top: Dimens.normalMargin),
                  child: const PersoTextField(title: "Nickname", customValidator: TextFieldValidator.validateNickname)),
              Container(
                  margin: const EdgeInsets.only(top: Dimens.biggerMargin),
                  child: PersoButton(width: 160.0, title: "Next", onTap: onTapLogic))
            ],
          ),
        ),
      ),
    );
  }

  void onTapLogic() {
    if(_formKey.currentState?.validate() == true){
      print("PKPK validated!");
    }
  }
}
