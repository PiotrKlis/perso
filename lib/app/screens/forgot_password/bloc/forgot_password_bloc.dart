import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perso/app/screens/forgot_password/event/forgot_password_event.dart';
import 'package:perso/app/screens/forgot_password/state/forgot_password_state.dart';
import 'package:perso/core/dependency_injection/get_it.dart';
import 'package:perso/data/auth/auth_service.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {

  ForgotPasswordBloc() : super(const ForgotPasswordState.initial()) {
    on<ResetPassword>((event, emitter) async {
      try {
        await _authProvider.resetPassword(event.email);
        emitter.call(const ForgotPasswordState.passwordResetSuccess());
      } catch (error) {
        var errorMessage = 'Something went wrong';
        if (error is FirebaseAuthException) {
          switch (error.code) {
            case 'email-already-in-use':
              errorMessage = 'Email already in use';
              break;
            case 'invalid-email':
              errorMessage = 'Invalid email';
              break;
            case 'user-not-found':
              errorMessage = 'Password is too weak';
              break;
          }
          emitter.call(ForgotPasswordState.error(errorMessage));
        }
      }
    });
  }
  final _authProvider = getIt.get<AuthService>();
}
