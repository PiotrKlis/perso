import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perso/app/screens/sign_in/event/sign_in_event.dart';
import 'package:perso/app/screens/sign_in/state/sign_in_state.dart';
import 'package:perso/core/dependency_injection/get_it.dart';
import 'package:perso/core/models/user_session_model.dart';
import 'package:perso/data/auth/auth_service.dart';
import 'package:perso/data/user_info/user_info_provider.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(const SignInState.initial()) {
    on<Init>((state, emit) async {
      //no-op
    });

    on<Login>((state, emit) async {
      try {
        emit(const SignInState.loading());
        final userCredentials = await _authProvider.login(
          email: state.email,
          password: state.password,
        );
        await _userInfoProvider.updateSessionModel(userCredentials.user!);
        if (_userSessionModel.isEmailVerified) {
          await _handleSuccessfulLogin(emit);
        } else {
          emit(const SignInState.error(message: 'Email not verified'));
        }
      } catch (error) {
        _handleLoginError(error, emit);
      }
    });
  }

  final _authProvider = getIt.get<AuthService>();
  final _userSessionModel = getIt.get<UserSessionModel>();
  final _userInfoProvider = getIt.get<UserInfoProvider>();

  Future<void> _handleSuccessfulLogin(Emitter<SignInState> emit) async {
    if (_userSessionModel.isProfileCreated) {
      emit(const SignInState.navigateToHomeScreen());
    } else {
      emit(const SignInState.navigateToProfileCreationScreen());
    }
  }

  void _handleLoginError(Object error, Emitter<SignInState> emit) {
    var errorMessage = 'Something went wrong';
    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'invalid-email':
          errorMessage = 'Invalid email';
          break;
        case 'user-disabled':
          errorMessage = 'Email is disabled';
          break;
        case 'user-not-found':
          errorMessage = 'User not found';
          break;
        case 'wrong-password':
          errorMessage = 'Invalid password';
          break;
      }
    }
    emit(SignInState.error(message: errorMessage));
  }
}
