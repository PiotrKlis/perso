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
      create: (context) => SignInBloc(),
      child: SafeArea(
        child: Scaffold(
          appBar: PersoAppBar(title: context.strings.sign_in),
          backgroundColor: PersoColors.lightBlue,
          body: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(Dimens.lMargin),
                  child: const ClipOval(
                    child:
                        Image(image: AssetImage('assets/icon/icon_black.png')),
                  ),
                ),
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: Dimens.xmMargin),
                    child: Text(
                      context.strings.sign_in,
                      style: ThemeText.largerTitleBold,
                    ),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                          top: Dimens.xlMargin,
                          left: Dimens.xmMargin,
                          right: Dimens.xmMargin,
                        ),
                        child: PersoTextField(
                          title: context.strings.login,
                          textEditingController: _loginController,
                          customValidator: TextFieldValidator.validateIsEmpty,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          top: Dimens.xmMargin,
                          left: Dimens.xmMargin,
                          right: Dimens.xmMargin,
                        ),
                        child: PersoTextField(
                          title: context.strings.password,
                          shouldObscureText: true,
                          textEditingController: _passwordController,
                          customValidator: TextFieldValidator.validateIsEmpty,
                        ),
                      ),
                    ],
                  ),
                ),
                BlocBuilder<SignInBloc, SignInState>(
                  builder: (context, state) {
                    return state.whenOrNull(
                          loading: () => Container(
                            margin: const EdgeInsets.all(Dimens.xmMargin),
                            child: const LinearProgressIndicator(),
                          ),
                          error: (message) => Container(
                            margin: const EdgeInsets.only(top: Dimens.xsMargin),
                            child: Text(
                              message,
                              style: ThemeText.calloutRegularRed,
                            ),
                          ),
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
                          context.clearAndNavigate(ScreenNavigationKey.home),
                    );
                  },
                  child: Container(),
                ),
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: Dimens.lMargin),
                    child: GestureDetector(
                      onTap: () => context
                          .pushNamed(ScreenNavigationKey.passwordRecovery),
                      child: Text(
                        context.strings.forgotten_password_title,
                        style: ThemeText.calloutBoldBlueText,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                      top: Dimens.lMargin,
                      left: Dimens.lMargin,
                      right: Dimens.lMargin,),
                  child: PersoButton(
                    title: context.strings.sign_in,
                    onTap: _loginUser,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: Dimens.lMargin),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(child: PersoIndentedDivider()),
                      Text(
                        context.strings.or,
                        style: ThemeText.footnoteRegularGrey,
                      ),
                      const Expanded(child: PersoIndentedDivider()),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(
                    Dimens.lMargin,
                  ),
                  child: PersoButton(
                    onTap: (context) {
                      context.pushNamed(ScreenNavigationKey.signUp);
                    },
                    title: context.strings.sign_up,
                    whiteBlackTheme: true,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _loginUser(BuildContext context) {
    if (_formKey.currentState?.validate() == true) {
      context.read<SignInBloc>().add(
            SignInEvent.login(
              email: _loginController.text,
              password: _passwordController.text,
            ),
          );
    }
  }
}
