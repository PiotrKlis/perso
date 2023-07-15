import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterProvider {
  Future<UserCredential> register(
      {required String email, required String password}) async {
    UserCredential userCredentials = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    await FirebaseAuth.instance.currentUser?.sendEmailVerification();
    return userCredentials;
  }
}
