import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:perso/app/screens/sign_up/bloc/sign_up_bloc.dart';
import 'package:perso/app/screens/sign_up/event/sign_up_event.dart';
import 'package:perso/app/screens/sign_up/state/sign_up_state.dart';
import 'package:perso/app/styleguide/styleguide.dart';
import 'package:perso/app/utils/validators.dart';
import 'package:perso/app/widgets/app_bar/perso_app_bar.dart';
import 'package:perso/app/widgets/perso_button.dart';
import 'package:perso/app/widgets/perso_indented_divider.dart';
import 'package:perso/app/widgets/perso_text_field.dart';
import 'package:perso/core/extensions/context_extensions.dart';
import 'package:perso/core/navigation/screen_navigation_key.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpBloc(const SignUpState.initial()),
      child: Scaffold(
        backgroundColor: PersoColors.lightBlue,
        appBar: PersoAppBar(title: context.strings.sign_up_title),
        body: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    top: Dimens.xlMargin,
                    left: Dimens.xmMargin,
                  ),
                  child: Text(
                    context.strings.sign_up_body_1,
                    style: ThemeText.largerTitleBold,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    top: Dimens.mMargin,
                    left: Dimens.xmMargin,
                  ),
                  child: Text(
                    context.strings.sign_up_body_2,
                    style: ThemeText.bodyRegularBlackText,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: Dimens.xlMargin),
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: Dimens.xmMargin),
                        child: const Icon(Icons.email, size: Dimens.iconSize),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(
                            left: Dimens.xmMargin,
                            right: Dimens.xmMargin,
                          ),
                          child: PersoTextField(
                            hintText: context.strings.email,
                            textEditingController: _loginController,
                            customValidator: TextFieldValidator.validateEmail,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    top: Dimens.xmMargin,
                    right: Dimens.xmMargin,
                  ),
                  child: const PersoIndentedDivider(),
                ),
                Container(
                  margin: const EdgeInsets.only(top: Dimens.lMargin),
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                          left: Dimens.xmMargin,
                        ),
                        child: const Icon(
                          Icons.password,
                          size: Dimens.iconSize,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(
                            left: Dimens.xmMargin,
                            right: Dimens.xmMargin,
                          ),
                          child: PersoTextField(
                            hintText: context.strings.password,
                            customValidator:
                                TextFieldValidator.validatePassword,
                            shouldObscureText: true,
                            passwordController: _passwordController,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: Dimens.lMargin),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(
                            left: Dimens.xxxlMargin,
                            right: Dimens.xmMargin,
                          ),
                          child: PersoTextField(
                            hintText: context.strings.confirm_password,
                            passwordController: _passwordController,
                            confirmPasswordController:
                                _confirmPasswordController,
                            shouldObscureText: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Container(
                    margin: const EdgeInsets.all(Dimens.xlMargin),
                    child: PersoButton(
                      title: context.strings.register,
                      onTap: _registerUser,
                    ),
                  ),
                ),
                BlocConsumer<SignUpBloc, SignUpState>(
                  builder: (context, state) {
                    return state.whenOrNull(
                          loading: () => const Center(
                            child: CircularProgressIndicator(
                              color: Colors.black,
                            ),
                          ),
                          error: (error) => Center(
                            child: Text(
                              error,
                              style: ThemeText.calloutRegularRed,
                            ),
                          ),
                        ) ??
                        Container();
                  },
                  listener: (context, state) {
                    if (state == const SignUpState.success()) {
                      context.replaceNamed(ScreenNavigationKey.signUpSuccess);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _registerUser(BuildContext context) {
    if (_formKey.currentState?.validate() == true) {
      context.read<SignUpBloc>().add(
            SignUpEvent.register(
              email: _loginController.text,
              password: _passwordController.text,
            ),
          );
    }
  }
}
