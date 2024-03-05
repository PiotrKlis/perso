import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perso/app/screens/forgot_password/bloc/forgot_password_bloc.dart';
import 'package:perso/app/screens/forgot_password/event/forgot_password_event.dart';
import 'package:perso/app/screens/forgot_password/state/forgot_password_state.dart';
import 'package:perso/app/styleguide/styleguide.dart';
import 'package:perso/app/utils/extension/context_extensions.dart';
import 'package:perso/app/widgets/perso_button.dart';
import 'package:perso/app/widgets/perso_text_field.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgotPasswordBloc(),
      child: Scaffold(
        backgroundColor: PersoColors.lightBlue,
        appBar: AppBar(
          title: Text(context.strings.password_recovery),
        ),
        body: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Container(
            margin: const EdgeInsets.all(Dimens.xmMargin),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: Dimens.xxlMargin),
                  child: const Icon(
                    Icons.lock,
                    size: Dimens.iconSizeLarge,
                    color: Colors.black,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: Dimens.xlMargin),
                  child: Text(
                    context.strings.forgotten_password_title,
                    style: ThemeText.largeTitleBold,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: Dimens.xlMargin),
                  child: Text(
                    context.strings.forgotten_password_subtitle,
                    style: ThemeText.bodyBoldBlackText,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: Dimens.sMargin),
                  child: Text(
                    context.strings.enter_email_forgotten_password,
                    style: ThemeText.bodyRegularBlackText,
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: Dimens.xmMargin),
                  child: PersoTextField(
                    hintText: context.strings.email,
                    textEditingController: _textEditingController,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: Dimens.xlMargin),
                  child: PersoButton(
                    title: context.strings.reset_password,
                    onTap: (context) {
                      context.read<ForgotPasswordBloc>().add(
                            ForgotPasswordEvent.resetPassword(
                              _textEditingController.text,
                            ),
                          );
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: Dimens.xmMargin),
                  child: BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
                    builder: (context, state) {
                      return state.whenOrNull(
                            passwordResetSuccess: () => Text(
                              context.strings.password_reset_success,
                              style: ThemeText.calloutRegular,
                            ),
                            error: Text.new,
                          ) ??
                          Container();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
