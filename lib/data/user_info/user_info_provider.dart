import 'package:Perso/core/user_type.dart';
import 'package:Perso/data/utils/firestore_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@singleton
class UserInfoProvider {
  User? user;

  Future<bool> isProfileCreated() async {
    final String? id = FirebaseAuth.instance.currentUser?.uid;
    final DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection(CollectionName.users)
        .doc(id)
        .get();
    return snapshot.exists;
  }

  Future<bool> isUserLoggedIn() async {
    if (user != null) {
      final bool doesProfileExist = await isProfileCreated();
      final bool isEmailVerified =
          FirebaseAuth.instance.currentUser!.emailVerified;
      if (doesProfileExist && isEmailVerified) {
        return true;
      }
    }
    return false;
  }

  Future<UserType?> getUserType() async {
    final bool isLoggedIn = await isUserLoggedIn();
    if (isLoggedIn) {
      final DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection(CollectionName.users)
          .doc(user?.uid)
          .get();
      String userType = snapshot.get(UserDocumentFields.userType);
      return userType.toUserType();
    } else {
      return null;
    }
  }

  void listenForFirebaseUserChange() {
    FirebaseAuth.instance.authStateChanges().listen((User? firebaseUser) {
      user = firebaseUser;
    });
  }

  Future<bool> isNicknameUnique(String nickname) async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection(CollectionName.users)
        .where(UserDocumentFields.nickname, isEqualTo: nickname)
        .get();
    return snapshot.docs.isEmpty;
  }
}
