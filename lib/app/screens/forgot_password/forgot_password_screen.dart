import 'package:Perso/app/screens/forgot_password/bloc/forgot_password_bloc.dart';
import 'package:Perso/app/screens/forgot_password/event/forgot_password_event.dart';
import 'package:Perso/app/screens/forgot_password/state/forgot_password_state.dart';
import 'package:Perso/app/utils/colors.dart';
import 'package:Perso/app/utils/dimens.dart';
import 'package:Perso/app/utils/theme_text.dart';
import 'package:Perso/app/widgets/perso_button.dart';
import 'package:Perso/app/widgets/perso_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'
;


class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ForgotPasswordBloc(const ForgotPasswordState.initial()),
      child: Scaffold(
        backgroundColor: PersoColors.lightBlue,
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.password_recovery),
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
                    child: const Icon(Icons.lock,
                        size: Dimens.iconSizeLarge, color: Colors.black)),
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
                    child: PersoTextField(
                      title: "Email",
                      textEditingController: _textEditingController,
                    )),
                Container(
                  margin: const EdgeInsets.only(top: Dimens.biggerMargin),
                  child: PersoButton(
                    title: "Reset Password",
                    onTap: (context) {
                      context.read<ForgotPasswordBloc>().add(
                          ForgotPasswordEvent.resetPassword(
                              _textEditingController.text));
                    },
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(top: Dimens.normalMargin),
                    child: BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
                      builder: (context, state) {
                        return state.whenOrNull(
                                passwordResetSuccess: () => Text(
                                    'Email with password reset instructions has been sent to an email you have provided. See you soon!',
                                    style: ThemeText.calloutRegular),
                                error: (error) => Text(error)) ??
                            Container();
                      },
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
