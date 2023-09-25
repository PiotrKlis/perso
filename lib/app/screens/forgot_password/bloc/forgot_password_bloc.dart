import 'package:Perso/app/screens/forgot_password/event/forgot_password_event.dart';
import 'package:Perso/app/screens/forgot_password/state/forgot_password_state.dart';
import 'package:Perso/core/dependency_injection/get_it_config.dart';
import 'package:Perso/data/auth/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final _authProvider = getIt.get<AuthService>();

  ForgotPasswordBloc(ForgotPasswordState initialState) : super(initialState) {
    on<ResetPassword>((event, emitter) async {
      try {
        await _authProvider.resetPassword(event.email);
        emitter.call(const ForgotPasswordState.passwordResetSuccess());
      } catch (error) {
        String errorMessage = "Something went wrong";
        if (error is FirebaseAuthException) {
          switch (error.code) {
            case 'email-already-in-use':
              errorMessage = "Email already in use";
              break;
            case 'invalid-email':
              errorMessage = "Invalid email";
              break;
            case 'user-not-found':
              errorMessage = "Password is too weak";
              break;
          }
          emitter.call(ForgotPasswordState.error(errorMessage));
        }
      }
    });
  }
}
