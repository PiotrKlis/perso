import 'package:Perso/app/screens/sign_in/bloc/sign_in_bloc.dart';
import 'package:Perso/app/screens/sign_in/event/sign_in_event.dart';
import 'package:Perso/app/screens/sign_in/state/sign_in_state.dart';
import 'package:Perso/app/utils/colors.dart';
import 'package:Perso/app/utils/dimens.dart';
import 'package:Perso/app/utils/theme_text.dart';
import 'package:Perso/app/utils/validators.dart';
import 'package:Perso/app/widgets/perso_button.dart';
import 'package:Perso/app/widgets/perso_divider.dart';
import 'package:Perso/app/widgets/perso_text_field.dart';
import 'package:Perso/core/navigation/screen_navigation_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInBloc(const SignInState.initial()),
      child: _signInScreenView(context),
    );
  }

  SafeArea _signInScreenView(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: PersoColors.lightBlue,
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
                            padding: EdgeInsets.all(16.0,),
                            child: Icon(Icons.cancel_outlined, size: 32.0,),
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
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                        margin: const EdgeInsets.only(
                            top: Dimens.biggerMargin,
                            left: Dimens.normalMargin,
                            right: Dimens.normalMargin),
                        child: PersoTextField(
                          title: "Login",
                          textEditingController: _loginController,
                          customValidator: TextFieldValidator.validateIsEmpty,
                        )),
                    Container(
                        margin: const EdgeInsets.only(
                            top: Dimens.normalMargin,
                            left: Dimens.normalMargin,
                            right: Dimens.normalMargin),
                        child: PersoTextField(
                          title: "Password",
                          shouldObscureText: true,
                          textEditingController: _passwordController,
                          customValidator: TextFieldValidator.validateIsEmpty,
                        )),
                  ],
                )),
            BlocBuilder<SignInBloc, SignInState>(
              builder: (context, state) {
                return state.whenOrNull(
                        loading: () => Container(
                            margin: const EdgeInsets.all(Dimens.normalMargin),
                            child: const LinearProgressIndicator()),
                        error: (message) => Container(
                            margin:
                                const EdgeInsets.only(top: Dimens.smallMargin),
                            child: Text(message,
                                style: ThemeText.calloutRegularRed)),
                        success: () {
                          context
                              .read<SignInBloc>()
                              .add(const SignInEvent.checkIsProfileCreated());
                          return Container();
                        }) ??
                    Container();
              },
            ),
            BlocListener<SignInBloc, SignInState>(
              listener: (context, state) {
                state.whenOrNull(
                    success: () => context
                        .read<SignInBloc>()
                        .add(const SignInEvent.checkIsProfileCreated()),
                    navigateToProfileCreationScreen: () =>
                        context.pushNamed(ScreenNavigationKey.profileCreation),
                    navigateToHomeScreen: () =>
                        context.replaceNamed(ScreenNavigationKey.home));
              },
              child: Container(),
            ),
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: Dimens.bigMargin),
                child: GestureDetector(
                  onTap: () =>
                      context.pushNamed(ScreenNavigationKey.passwordRecovery),
                  child: Text(
                    "Forgot password?",
                    style: ThemeText.calloutBoldBlueText,
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: Dimens.bigMargin),
                child: PersoButton(
                  width: Dimens.bigButtonWidth,
                  title: "Sign In",
                  onTap: (context) {
                    _loginUser(context);
                  },
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: Dimens.bigMargin),
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
                    top: Dimens.bigMargin,
                    left: Dimens.bigMargin,
                    right: Dimens.bigMargin),
                child: GestureDetector(
                  onTap: () => context.pushNamed(ScreenNavigationKey.signUp),
                  child: const AbsorbPointer(
                    child: PersoButton(title: "Sign up", whiteBlackTheme: true),
                  ),
                )),
          ],
        ),
      ),
    ));
  }

  void _loginUser(BuildContext context) {
    if (_formKey.currentState?.validate() == true) {
      context.read<SignInBloc>().add(SignInEvent.login(
          email: _loginController.text, password: _passwordController.text));
    }
  }
}
