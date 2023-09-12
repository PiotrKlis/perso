import 'package:Perso/data/shared_prefs/perso_shared_prefs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

@injectable
class AuthProvider {
  final PersoSharedPrefs _sharedPrefs = GetIt.I.get<PersoSharedPrefs>();

  Future<UserCredential> register(
      {required String email, required String password}) async {
    UserCredential userCredentials = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    await FirebaseAuth.instance.currentUser?.sendEmailVerification();
    return userCredentials;
  }

  Future<UserCredential> login(
      {required String email, required String password}) async {
    return await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  bool isUserLoggedIn() {
    if (FirebaseAuth.instance.currentUser != null &&
        FirebaseAuth.instance.currentUser!.emailVerified &&
        _sharedPrefs.getBool(PersoSharedPrefs.isProfileCreatedKey)) {
      return true;
    } else {
      return false;
    }
  }

  Future resetPassword(String email) async {
    FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
}
