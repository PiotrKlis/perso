import 'package:freezed_annotation/freezed_annotation.dart';
part 'sign_in_state.freezed.dart';

@freezed
class SignInState with _$SignInState {
  const factory SignInState.initial() = Initial;
  const factory SignInState.loading() = Loading;
  const factory SignInState.error({required String message}) = Error;
  const factory SignInState.success() = Success;
  const factory SignInState.navigateToFirstLoginScreen() = NavigateToFirstLoginScreen;
  const factory SignInState.navigateToHomeScreen() = NavigateToHomeScreen;
}
