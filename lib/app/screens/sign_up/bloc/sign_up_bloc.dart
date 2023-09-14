import 'package:Perso/app/screens/sign_up/event/sign_up_event.dart';
import 'package:Perso/app/screens/sign_up/state/sign_up_state.dart';
import 'package:Perso/data/auth/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthService _authProvider = GetIt.I.get<AuthService>();

  SignUpBloc(SignUpState initialState) : super(initialState) {
    on<Init>((state, emit) async {
      //no-op
    });

    on<Register>((state, emit) async {
      try {
        emit(const SignUpState.loading());
        await _authProvider.register(
            email: state.email, password: state.password);
        emit(const SignUpState.success());
      } catch (error) {
        _handleRegistrationError(error, emit);
      }
    });
  }

  void _handleRegistrationError(Object error, Emitter<SignUpState> emit) {
    String errorMessage = "Something went wrong";
    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'email-already-in-use':
          errorMessage = "Email already in use";
          break;
        case 'invalid-email':
          errorMessage = "Invalid email";
          break;
        case 'weak-password':
          errorMessage = "Password is too weak";
          break;
        case 'operation-not-allowed':
          errorMessage = "Email/password accounts are not enabled";
          break;
      }
    }
    emit(SignUpState.error(message: errorMessage));
  }
}
