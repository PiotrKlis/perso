import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:perso/core/dependency_injection/get_it.dart';
import 'package:perso/core/models/user_session_model.dart';

@injectable
class AuthService {
  final _userSessionModel = getIt.get<UserSessionModel>();

  Future<UserCredential> register({
    required String email,
    required String password,
  }) async {
    final userCredentials = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    await _userSessionModel.user?.sendEmailVerification();
    return userCredentials;
  }

  Future<UserCredential> login({
    required String email,
    required String password,
  }) async {
    return FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> resetPassword(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
