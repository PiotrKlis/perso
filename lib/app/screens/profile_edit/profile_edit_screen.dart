import 'package:Perso/app/screens/profile_edit/spoken_language_row.dart';
import 'package:Perso/app/utils/colors.dart';
import 'package:Perso/app/utils/dimens.dart';
import 'package:Perso/app/utils/validators.dart';
import 'package:Perso/app/widgets/perso_autocomplete.dart';
import 'package:Perso/app/widgets/perso_button.dart';
import 'package:Perso/app/widgets/perso_divider.dart';
import 'package:Perso/app/widgets/perso_text_field.dart';
import 'package:flutter/material.dart';

class ProfileEditScreen extends StatelessWidget {
  ProfileEditScreen({Key? key}) : super(key: key);

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
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                    margin: const EdgeInsets.only(top: Dimens.bigMargin),
                    child: const Icon(
                      Icons.account_circle,
                      size: 160.0,
                    )),
              ),
              //TODO: Add image upload functionality
              // https://pub.dev/packages/image_picker
              const Center(child: PersoButton(title: "Upload image")),
              Container(
                  margin: const EdgeInsets.only(top: Dimens.bigMargin),
                  child: const SpokenLanguageRowWidget()),
              Container(
                  margin: const EdgeInsets.only(
                      top: Dimens.normalMargin, right: Dimens.normalMargin),
                  child: const PersoDivider()),
              Container(
                margin: const EdgeInsets.only(top: Dimens.normalMargin),
                child: Row(
                  children: [
                    Container(
                        margin:
                            const EdgeInsets.only(left: Dimens.normalMargin),
                        child: const Icon(Icons.email, size: 24.0)),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(
                            left: Dimens.normalMargin,
                            right: Dimens.normalMargin),
                        child: const PersoTextField(
                            title: "Email",
                            customValidator: TextFieldValidator.validateEmail),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(top: Dimens.bigMargin),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          margin:
                              const EdgeInsets.only(left: Dimens.normalMargin),
                          child: const Icon(Icons.password, size: 24.0)),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(
                              left: Dimens.normalMargin,
                              right: Dimens.normalMargin),
                          child: const PersoTextField(
                            title: "Password",
                            customValidator:
                                TextFieldValidator.validatePassword,
                            shouldObscureText: true,
                          ),
                        ),
                      ),
                    ],
                  )),
              Container(
                  margin: const EdgeInsets.only(
                      top: Dimens.normalMargin, right: Dimens.normalMargin),
                  child: const PersoDivider()),
              Container(
                  margin: const EdgeInsets.only(top: Dimens.bigMargin),
                  child: Row(
                    children: [
                      Container(
                          margin:
                              const EdgeInsets.only(left: Dimens.normalMargin),
                          child: const Icon(Icons.person, size: 24.0)),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(
                              left: Dimens.normalMargin,
                              right: Dimens.normalMargin),
                          child: const PersoTextField(
                              title: "Name",
                              customValidator:
                                  TextFieldValidator.validateIsEmpty),
                        ),
                      ),
                    ],
                  )),
              Container(
                margin: const EdgeInsets.only(
                    left: Dimens.substantialMargin,
                    top: Dimens.bigMargin,
                    right: Dimens.normalMargin),
                child: const PersoTextField(
                    title: "Surname",
                    customValidator: TextFieldValidator.validateIsEmpty),
              ),
              Container(
                  margin: const EdgeInsets.only(
                      left: Dimens.substantialMargin,
                      top: Dimens.bigMargin,
                      right: Dimens.normalMargin),
                  child: const PersoTextField(
                      // TODO: Combine name & surname by default
                      title: "Nickname",
                      customValidator: TextFieldValidator.validateNickname)),
              Container(
                  margin: const EdgeInsets.only(
                      top: Dimens.normalMargin, right: Dimens.normalMargin),
                  child: const PersoDivider()),
              Container(
                  margin: const EdgeInsets.only(
                      top: Dimens.normalMargin, right: Dimens.normalMargin),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          margin:
                              const EdgeInsets.only(left: Dimens.normalMargin),
                          child: const Icon(Icons.pin_drop, size: 24.0)),
                      Expanded(
                        child: Container(
                            margin: const EdgeInsets.only(
                                left: Dimens.normalMargin),
                            child: PersoAutocomplete()),
                      ),
                    ],
                  )),
              Container(
                  margin: const EdgeInsets.only(
                      top: Dimens.normalMargin, right: Dimens.normalMargin),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          margin:
                              const EdgeInsets.only(left: Dimens.normalMargin),
                          child: const Icon(Icons.phone, size: 24.0)),
                      Expanded(
                        child: Container(
                          margin:
                              const EdgeInsets.only(left: Dimens.normalMargin),
                          child: const PersoTextField(
                            title: "Phone number",
                            customValidator: TextFieldValidator.validateDigits,
                            textInputType: TextInputType.phone,
                          ),
                        ),
                      ),
                    ],
                  )),
              Container(
                  margin: const EdgeInsets.only(
                      top: Dimens.normalMargin, right: Dimens.normalMargin),
                  child: const PersoDivider()),
              Container(
                  margin: const EdgeInsets.only(
                      top: Dimens.normalMargin, right: Dimens.normalMargin),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          margin:
                              const EdgeInsets.only(left: Dimens.normalMargin),
                          child: const Icon(Icons.text_snippet, size: 24.0)),
                      Expanded(
                        child: Container(
                          height: 140.0,
                          margin:
                              const EdgeInsets.only(left: Dimens.normalMargin),
                          child: const PersoTextField(
                            title: "Short Bio",
                            customValidator:
                                TextFieldValidator.validateNickname,
                            isMultiLine: true,
                            maxLength: 150,
                          ),
                        ),
                      ),
                    ],
                  )),
              Container(
                  height: 340.0,
                  margin: const EdgeInsets.only(
                      left: Dimens.substantialMargin,
                      top: Dimens.normalMargin,
                      right: Dimens.normalMargin),
                  child: const PersoTextField(
                      title: "Long bio",
                      isMultiLine: true,
                      maxLength: 500,
                      customValidator: TextFieldValidator.validateNickname)),
              Center(
                child: Container(
                    margin: const EdgeInsets.only(
                        top: Dimens.biggerMargin,
                        bottom: Dimens.biggerMargin,
                        right: Dimens.normalMargin),
                    child: PersoButton(
                        width: 160.0, title: "Next", onTap: onTapLogic)),
              ),
              SizedBox(
                width: 300,
                height: 300,
                child: Image.asset("assets/images/trainer3.png"),
                //Image(image: AssetImage("assets/images/screenshot.png")
              )
            ],
          ),
        ),
      ),
    );
  }

  void onTapLogic(BuildContext _) {
    if (_formKey.currentState?.validate() == true) {
      //TODO: Send data to firestore
      print("PKPK validated!");
    }
  }
}
