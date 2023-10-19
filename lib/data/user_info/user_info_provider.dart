import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:perso/core/user_type.dart';
import 'package:perso/data/utils/firestore_constants.dart';

@singleton
class UserInfoProvider {
  User? user;

  Future<bool> isProfileCreated() async {
    final id = FirebaseAuth.instance.currentUser?.uid;
    final DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection(CollectionName.users)
        .doc(id)
        .get();
    return snapshot.exists;
  }

  Future<bool> isUserLoggedIn() async {
    if (user != null) {
      final doesProfileExist = await isProfileCreated();
      final isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
      if (doesProfileExist && isEmailVerified) {
        return true;
      }
    }
    return false;
  }

  Future<UserType?> getUserType() async {
    final isLoggedIn = await isUserLoggedIn();
    if (isLoggedIn) {
      final DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection(CollectionName.users)
          .doc(user?.uid)
          .get();
      final userType = snapshot.get(UserDocumentFields.userType) as String;
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
