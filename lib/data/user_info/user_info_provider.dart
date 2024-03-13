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
    final userType = await _getUserType(user.uid);
    await userSessionModel.update(
      user: user,
      isProfileCreated: userType != null,
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
    });
  }

  Future<bool> isNicknameUnique(String nickname) async {
    final QuerySnapshot userSnapshot = await FirebaseFirestore.instance
        .collection(CollectionName.users)
        .where(UserDocumentFields.nickname, isEqualTo: nickname)
        .get();

    return userSnapshot.docs.isEmpty;
  }

  Future<UserType?> _getUserType(String uid) async {
    final DocumentSnapshot usersSnapshot = await FirebaseFirestore.instance
        .collection(CollectionName.users)
        .doc(uid)
        .get();

    if (usersSnapshot.exists) {
      final userType =
          (usersSnapshot[UserDocumentFields.userType] as String).toUserType();
      switch (userType) {
        case UserType.trainer:
          return UserType.trainer;
        case UserType.client:
          return UserType.client;
      }
    } else {
      return null;
    }
  }
}
