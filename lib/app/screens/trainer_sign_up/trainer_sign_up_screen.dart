import 'package:Perso/app/utils/colors.dart';
import 'package:Perso/app/utils/dimens.dart';
import 'package:Perso/app/utils/validators.dart';
import 'package:Perso/app/widgets/perso_autocomplete.dart';
import 'package:Perso/app/widgets/perso_button.dart';
import 'package:Perso/app/widgets/perso_divider.dart';
import 'package:Perso/app/widgets/perso_flag_button.dart';
import 'package:Perso/app/widgets/perso_small_button.dart';
import 'package:Perso/app/widgets/perso_text_field.dart';
import 'package:flutter/material.dart';

class TrainerSignUpScreen extends StatelessWidget {
  TrainerSignUpScreen({Key? key}) : super(key: key);

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
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                    margin: const EdgeInsets.only(top: Dimens.bigMargin),
                    child: const Icon(
                      Icons.photo,
                      size: 96.0,
                    )),
              ),
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
                              customValidator: TextFieldValidator.validateName),
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
                    customValidator: TextFieldValidator.validateName),
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
              LanguageRow(),
              Center(
                child: Container(
                    margin: const EdgeInsets.only(
                        top: Dimens.biggerMargin,
                        bottom: Dimens.biggerMargin,
                        right: Dimens.normalMargin),
                    child: PersoButton(
                        width: 160.0, title: "Next", onTap: onTapLogic)),
              )
            ],
          ),
        ),
      ),
    );
  }

  void onTapLogic() {
    if (_formKey.currentState?.validate() == true) {
      print("PKPK validated!");
    }
  }
}

class LanguageRow extends StatefulWidget {
  const LanguageRow({Key? key}) : super(key: key);

  @override
  State<LanguageRow> createState() => _LanguageRowState();
}

class _LanguageRowState extends State<LanguageRow> {
  List<Map<String, Widget>> listOfLanguages = [];

  @override
  Widget build(BuildContext context) {
    List<Widget> languageWidgets = listOfLanguages
        .map((map) => map.values.toList())
        .expand((list) => list)
        .toList();

    return Container(
        margin: const EdgeInsets.only(
            top: Dimens.normalMargin, right: Dimens.normalMargin),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  margin: const EdgeInsets.only(left: Dimens.normalMargin),
                  child: const Icon(Icons.flag, size: 24.0)),
              Container(
                  margin: const EdgeInsets.only(left: Dimens.normalMargin),
                  child: PersoSmallButton(text: "Add spoken language", addLanguage: addSpokenLanguage)),
              ...languageWidgets
            ],
          ),
        ));
  }

  void addSpokenLanguage(String languageEmoji) {
    Widget languageChip = Container(
        margin: const EdgeInsets.only(left: Dimens.normalMargin),
        child: PersoFlagButton(flagEmoji: languageEmoji));
    setState(() {
      listOfLanguages.add({languageEmoji: languageChip});
    });
  }

  void removeSpokenLanguage(String languageEmoji) {
    setState(() {
      listOfLanguages
          .removeWhere((element) => element.containsKey(languageEmoji));
    });
  }
}
