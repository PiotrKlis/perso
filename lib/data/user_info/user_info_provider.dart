import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:perso/core/dependency_injection/get_it.dart';
import 'package:perso/core/models/user_session_model.dart';
import 'package:perso/core/models/user_type.dart';
import 'package:perso/data/utils/firestore_constants.dart';

@Singleton()
class UserInfoProvider {
  final userSessionModel = getIt.get<UserSessionModel>();

  Future<void> updateSessionModel(User user) async {
    final isProfileCreated = await _isProfileCreated(user.uid);
    final userType = await _getUserType(user.uid);
    await userSessionModel.update(
      user: user,
      isProfileCreated: isProfileCreated,
      userType: userType,
      isEmailVerified: user.emailVerified,
    );
  }

  void listenForFirebaseUserChange() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user != null) {
        await updateSessionModel(user);
      } else {
        userSessionModel.reset();
      }
      //update session model
    });
  }

  Future<bool> _isProfileCreated(String uid) async {
    final DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection(CollectionName.users)
        .doc(uid)
        .get();
    return snapshot.exists;
  }

  Future<UserType?> _getUserType(String uid) async {
    final DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection(CollectionName.users)
        .doc(uid)
        .get();
    if (snapshot.exists) {
      final userType = snapshot.get(UserDocumentFields.userType) as String;
      return userType.toUserType();
    } else {
      return null;
    }
  }

//TODO: Fixme
  Future<bool> isNicknameUnique(String nickname) async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection(CollectionName.users)
        .where(UserDocumentFields.nickname, isEqualTo: nickname)
        .get();
    return snapshot.docs.isEmpty;
  }
}
