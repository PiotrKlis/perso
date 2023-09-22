import 'package:Perso/core/dependency_injection/get_it_config.dart';
import 'package:Perso/core/user_type.dart';
import 'package:Perso/data/shared_prefs/perso_shared_prefs.dart';
import 'package:Perso/data/utils/firestore_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@singleton
class UserInfoProvider {
  User? user;
  final PersoSharedPrefs _sharedPrefs = getIt.get<PersoSharedPrefs>();

  bool isUserLoggedIn() {
    if (user?.uid != null &&
        FirebaseAuth.instance.currentUser!.emailVerified &&
        _sharedPrefs.getBool(PersoSharedPrefs.isProfileCreatedKey)) {
      return true;
    } else {
      return false;
    }
  }

  Future<UserType> getUserType() async {
    final DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection(CollectionName.users)
        .doc(user?.uid)
        .get();
    String userType = snapshot.get(UserDocumentFields.userType);
    return userType.toUserType();
  }

  void listenForFirebaseUserChange() {
    FirebaseAuth.instance.authStateChanges().listen((User? firebaseUser) {
      user = firebaseUser;
      print("PKPK $user");
    });
  }

  Future<bool> isNicknameUnique(String nickname) async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection(CollectionName.users)
        .doc(nickname)
        .get();
    bool doesNicknameExist = snapshot.exists;
    return !doesNicknameExist;
  }
}
