import 'package:perso/app/screens/sign_in/event/sign_in_event.dart';
import 'package:perso/app/screens/sign_in/state/sign_in_state.dart';
import 'package:perso/core/dependency_injection/get_it.dart';
import 'package:perso/data/auth/auth_service.dart';
import 'package:perso/data/user_info/user_info_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final AuthService _authProvider = getIt.get<AuthService>();
  final UserInfoProvider _userInfoProvider = getIt.get<UserInfoProvider>();

  SignInBloc(SignInState initialState) : super(initialState) {
    on<Init>((state, emit) async {
      //no-op
    });

    on<Login>((state, emit) async {
      try {
        emit(const SignInState.loading());
        UserCredential userCredential = await _authProvider.login(
            email: state.email, password: state.password);
        // if (userCredential.user!.emailVerified) {
        await _handleSuccessfulLogin(emit);
        // } else {
        //   emit(const SignInState.error(message: "Email not verified"));
        // }
      } catch (error) {
        _handleLoginError(error, emit);
      }
    });
  }

  Future<void> _handleSuccessfulLogin(Emitter<SignInState> emit) async {
    final bool isUserLoggedIn = await _userInfoProvider.isUserLoggedIn();
    if (isUserLoggedIn) {
      emit(const SignInState.navigateToHomeScreen());
    } else {
      emit(const SignInState.navigateToProfileCreationScreen());
    }
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
