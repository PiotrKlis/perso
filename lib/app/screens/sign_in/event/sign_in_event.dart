import 'package:freezed_annotation/freezed_annotation.dart';
part 'sign_in_event.freezed.dart';

@freezed
class SignInEvent with _$SignInEvent {
  const factory SignInEvent.init() = Init;
  const factory SignInEvent.login(
      {required String email, required String password}) = Login;
  const factory SignInEvent.checkIsProfileCreated() = CheckIsProfileCreated;
}
