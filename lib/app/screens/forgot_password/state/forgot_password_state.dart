import 'package:freezed_annotation/freezed_annotation.dart';
part 'forgot_password_state.freezed.dart';

@freezed
class ForgotPasswordState with _$ForgotPasswordState {
  const factory ForgotPasswordState.initial() = Initial;
  const factory ForgotPasswordState.passwordResetSuccess() = PasswordResetSuccess;
  const factory ForgotPasswordState.error(String error) = Error;

}
