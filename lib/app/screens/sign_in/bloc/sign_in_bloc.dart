import 'package:Perso/app/screens/sign_in/event/sign_in_event.dart';
import 'package:Perso/app/screens/sign_in/state/sign_in_state.dart';
import 'package:Perso/data/auth/auth_provider.dart';
import 'package:Perso/data/shared_prefs/perso_shared_prefs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final AuthProvider _authProvider = GetIt.I.get<AuthProvider>();
  final PersoSharedPrefs _persoSharedPrefs = GetIt.I.get<PersoSharedPrefs>();

  SignInBloc(SignInState initialState) : super(initialState) {
    on<Init>((state, emit) async {
      //no-op
    });

    on<Login>((state, emit) async {
      try {
        emit(const SignInState.loading());
        UserCredential userCredential = await _authProvider.login(
            email: state.email, password: state.password);
        if (userCredential.user!.emailVerified) {
          emit(const SignInState.error(message: "Email not verified"));
        }
        emit(const SignInState.success());
      } catch (error) {
        _handleLoginError(error, emit);
      }
    });

    on<CheckFirstLogin>((state, emit) async {
      if (_persoSharedPrefs.getBool("isFirstLogin", defaultValue: true)) {
        emit(const SignInState.navigateToFirstLoginScreen());
      } else {
        emit(const SignInState.navigateToHomeScreen());
      }
    });
  }

  void _handleLoginError(Object error, Emitter<SignInState> emit) {
    String errorMessage = "Something went wrong";
    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'invalid-email':
          errorMessage = "Invalid email";
          break;
        case 'user-disabled':
          errorMessage = "Email is disabled";
          break;
        case 'user-not-found':
          errorMessage = "User not found";
          break;
        case 'wrong-password':
          errorMessage = "Invalid password";
          break;
      }
    }
    emit(SignInState.error(message: errorMessage));
  }
}
