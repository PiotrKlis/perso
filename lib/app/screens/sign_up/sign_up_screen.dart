import 'package:Perso/app/models/account_type.dart';
import 'package:Perso/app/screens/sign_up/bloc/sign_up_bloc.dart';
import 'package:Perso/app/screens/sign_up/event/sign_up_event.dart';
import 'package:Perso/app/screens/sign_up/state/sign_up_state.dart';
import 'package:Perso/app/utils/colors.dart';
import 'package:Perso/app/utils/dimens.dart';
import 'package:Perso/app/utils/theme_text.dart';
import 'package:Perso/app/utils/validators.dart';
import 'package:Perso/app/widgets/perso_button.dart';
import 'package:Perso/app/widgets/perso_divider.dart';
import 'package:Perso/app/widgets/perso_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key, required this.accountType}) : super(key: key);

  final AccountType accountType;
  final _formKey = GlobalKey<FormState>();
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpBloc(const SignUpState.loading()),
      child: _signUpScreenView(),
    );
  }

  Widget _signUpScreenView() {
    return Scaffold(
      backgroundColor: PersoColors.lightBlue,
      appBar: AppBar(
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: PersoColors.lightWhite,
        title: Text(
          "Sign up new ${accountType.name}",
          style: ThemeText.bodyBoldBlackText,
        ),
      ),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocListener<SignUpBloc, SignUpState>(
                  listener: (context, state) {
                    if (state == SignUpState.loading()) {
                      CircularProgressIndicator();
                    }
                  },
                  child: Container()),
              Container(
                  margin: const EdgeInsets.only(
                      top: Dimens.biggerMargin, left: Dimens.normalMargin),
                  child: Text("Create your account",
                      style: ThemeText.largerTitleBold)),
              Container(
                  margin: const EdgeInsets.only(
                      top: Dimens.mediumMargin, left: Dimens.normalMargin),
                  child: Text("We are glad that you join us",
                      style: ThemeText.bodyRegularBlackText)),
              Container(
                margin: const EdgeInsets.only(top: Dimens.biggerMargin),
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
                  margin: const EdgeInsets.only(
                      top: Dimens.normalMargin, right: Dimens.normalMargin),
                  child: const PersoDivider()),
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
                          child: PersoTextField(
                            title: "Password",
                            customValidator:
                                TextFieldValidator.validatePassword,
                            shouldObscureText: true,
                            passwordController: _passwordController,
                          ),
                        ),
                      ),
                    ],
                  )),
              Container(
                  margin: const EdgeInsets.only(top: Dimens.bigMargin),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(
                              left: Dimens.substantialMargin,
                              right: Dimens.normalMargin),
                          child: PersoTextField(
                            title: "Confirm password",
                            passwordController: _passwordController,
                            confirmPasswordController:
                                _confirmPasswordController,
                            shouldObscureText: true,
                          ),
                        ),
                      ),
                    ],
                  )),
              Center(
                child: Container(
                    margin: const EdgeInsets.only(
                        top: Dimens.substantialMargin,
                        bottom: Dimens.biggerMargin,
                        right: Dimens.normalMargin),
                    child: PersoButton(
                        width: 160.0, title: "Register", onTap: _registerUser)),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _registerUser(BuildContext context) {
    if (_formKey.currentState?.validate() == true) {
      context.read<SignUpBloc>().add(SignUpEvent.register(
          email: _loginController.text, password: _passwordController.text));
    }
  }
}
