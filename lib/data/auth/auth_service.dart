import 'package:Perso/core/dependency_injection/get_it_config.dart';
import 'package:Perso/data/user_info/user_info_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:injectable/injectable.dart';

@injectable
class AuthService {
  final UserInfoProvider _userInfoProvider = getIt.get<UserInfoProvider>();

  Future<UserCredential> register(
      {required String email, required String password}) async {
    UserCredential userCredentials = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    await _userInfoProvider.user?.sendEmailVerification();
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

  Future logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
