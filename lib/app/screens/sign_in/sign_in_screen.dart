import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:perso/app/screens/sign_in/bloc/sign_in_bloc.dart';
import 'package:perso/app/screens/sign_in/event/sign_in_event.dart';
import 'package:perso/app/screens/sign_in/state/sign_in_state.dart';
import 'package:perso/app/styleguide/styleguide.dart';
import 'package:perso/app/utils/extension/context_extensions.dart';
import 'package:perso/app/utils/validators.dart';
import 'package:perso/app/widgets/perso_app_bar.dart';
import 'package:perso/app/widgets/perso_button.dart';
import 'package:perso/app/widgets/perso_indented_divider.dart';
import 'package:perso/app/widgets/perso_text_field.dart';
import 'package:perso/core/navigation/screen_navigation_key.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInBloc(const SignInState.initial()),
      child: SafeArea(
          child: Scaffold(
        appBar: PersoAppBar(title: context.strings.sign_in),
        backgroundColor: PersoColors.lightBlue,
        body: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            children: [
              const Icon(Icons.logo_dev, size: 160),
              Center(
                child: Container(
                    margin: const EdgeInsets.only(top: Dimens.normalMargin),
                    child: Text(context.strings.sign_in,
                        style: ThemeText.largerTitleBold,),),
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                          margin: const EdgeInsets.only(
                              top: Dimens.biggerMargin,
                              left: Dimens.normalMargin,
                              right: Dimens.normalMargin,),
                          child: PersoTextField(
                            title: context.strings.login,
                            textEditingController: _loginController,
                            customValidator: TextFieldValidator.validateIsEmpty,
                          ),),
                      Container(
                          margin: const EdgeInsets.only(
                              top: Dimens.normalMargin,
                              left: Dimens.normalMargin,
                              right: Dimens.normalMargin,),
                          child: PersoTextField(
                            title: context.strings.password,
                            shouldObscureText: true,
                            textEditingController: _passwordController,
                            customValidator: TextFieldValidator.validateIsEmpty,
                          ),),
                    ],
                  ),),
              BlocBuilder<SignInBloc, SignInState>(
                builder: (context, state) {
                  return state.whenOrNull(
                        loading: () => Container(
                            margin: const EdgeInsets.all(Dimens.normalMargin),
                            child: const LinearProgressIndicator(),),
                        error: (message) => Container(
                            margin:
                                const EdgeInsets.only(top: Dimens.smallMargin),
                            child: Text(message,
                                style: ThemeText.calloutRegularRed,),),
                      ) ??
                      Container();
                },
              ),
              BlocListener<SignInBloc, SignInState>(
                listener: (context, state) {
                  state.whenOrNull(
                      navigateToProfileCreationScreen: () => context
                          .pushNamed(ScreenNavigationKey.profileCreation),
                      navigateToHomeScreen: () =>
                          context.replaceNamed(ScreenNavigationKey.home),);
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
                      context.strings.forgotten_password_title,
                      style: ThemeText.calloutBoldBlueText,
                    ),
                  ),
                ),
              ),
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: Dimens.bigMargin),
                  child: PersoButton(
                    title: context.strings.sign_in,
                    onTap: _loginUser,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: Dimens.bigMargin),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(child: PersoIndentedDivider()),
                      Text(context.strings.or,
                          style: ThemeText.footnoteRegularGrey,),
                      const Expanded(child: PersoIndentedDivider()),
                    ],),
              ),
              Container(
                  margin: const EdgeInsets.only(
                      top: Dimens.bigMargin,
                      left: Dimens.bigMargin,
                      right: Dimens.bigMargin,),
                  child: GestureDetector(
                    onTap: () => context.pushNamed(ScreenNavigationKey.signUp),
                    child: AbsorbPointer(
                      child: PersoButton(
                          title: context.strings.sign_up,
                          whiteBlackTheme: true,),
                    ),
                  ),),
            ],
          ),
        ),
      ),),
    );
  }

  SafeArea _signInScreenView(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: PersoAppBar(title: context.strings.sign_in),
      backgroundColor: PersoColors.lightBlue,
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          children: [
            const Icon(Icons.logo_dev, size: 160),
            Center(
              child: Container(
                  margin: const EdgeInsets.only(top: Dimens.normalMargin),
                  child: Text(context.strings.sign_in,
                      style: ThemeText.largerTitleBold,),),
            ),
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                        margin: const EdgeInsets.only(
                            top: Dimens.biggerMargin,
                            left: Dimens.normalMargin,
                            right: Dimens.normalMargin,),
                        child: PersoTextField(
                          title: context.strings.login,
                          textEditingController: _loginController,
                          customValidator: TextFieldValidator.validateIsEmpty,
                        ),),
                    Container(
                        margin: const EdgeInsets.only(
                            top: Dimens.normalMargin,
                            left: Dimens.normalMargin,
                            right: Dimens.normalMargin,),
                        child: PersoTextField(
                          title: context.strings.password,
                          shouldObscureText: true,
                          textEditingController: _passwordController,
                          customValidator: TextFieldValidator.validateIsEmpty,
                        ),),
                  ],
                ),),
            BlocBuilder<SignInBloc, SignInState>(
              builder: (context, state) {
                return state.whenOrNull(
                      loading: () => Container(
                          margin: const EdgeInsets.all(Dimens.normalMargin),
                          child: const LinearProgressIndicator(),),
                      error: (message) => Container(
                          margin:
                              const EdgeInsets.only(top: Dimens.smallMargin),
                          child: Text(message,
                              style: ThemeText.calloutRegularRed,),),
                    ) ??
                    Container();
              },
            ),
            BlocListener<SignInBloc, SignInState>(
              listener: (context, state) {
                state.whenOrNull(
                    navigateToProfileCreationScreen: () =>
                        context.pushNamed(ScreenNavigationKey.profileCreation),
                    navigateToHomeScreen: () =>
                        context.replaceNamed(ScreenNavigationKey.home),);
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
                    context.strings.forgotten_password_title,
                    style: ThemeText.calloutBoldBlueText,
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: Dimens.bigMargin),
                child: PersoButton(
                  title: context.strings.sign_in,
                  onTap: _loginUser,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: Dimens.bigMargin),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(child: PersoIndentedDivider()),
                    Text(context.strings.or,
                        style: ThemeText.footnoteRegularGrey,),
                    const Expanded(child: PersoIndentedDivider()),
                  ],),
            ),
            Container(
                margin: const EdgeInsets.only(
                    top: Dimens.bigMargin,
                    left: Dimens.bigMargin,
                    right: Dimens.bigMargin,),
                child: GestureDetector(
                  onTap: () => context.pushNamed(ScreenNavigationKey.signUp),
                  child: AbsorbPointer(
                    child: PersoButton(
                        title: context.strings.sign_up, whiteBlackTheme: true,),
                  ),
                ),),
          ],
        ),
      ),
    ),);
  }

  void _loginUser(BuildContext context) {
    if (_formKey.currentState?.validate() == true) {
      context.read<SignInBloc>().add(SignInEvent.login(
          email: _loginController.text, password: _passwordController.text,),);
    }
  }
}
