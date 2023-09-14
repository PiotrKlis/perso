import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@injectable
class AuthService {
  Future<UserCredential> register(
      {required String email, required String password}) async {
    UserCredential userCredentials = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    await FirebaseAuth.instance.currentUser?.sendEmailVerification();
    return userCredentials;
  }

  Future<UserCredential> login(
      {required String email, required String password}) async {
    return FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  Future resetPassword(String email) async {
    FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
}
