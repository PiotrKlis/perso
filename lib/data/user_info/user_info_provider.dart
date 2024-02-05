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
    final isProfileCreated = await _isProfileCreated(user.uid, userType);
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

  Future<bool> _isProfileCreated(String uid, UserType? userType) async {
    if (userType == null) {
      return false;
    } else {
      final DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection(userType.toCollectionName())
          .doc(uid)
          .get();
      return snapshot.exists;
    }
  }

  Future<UserType?> _getUserType(String uid) async {
    final DocumentSnapshot clientsSnapshot = await FirebaseFirestore.instance
        .collection(CollectionName.clients)
        .doc(uid)
        .get();

    final DocumentSnapshot trainersSnapshot = await FirebaseFirestore.instance
        .collection(CollectionName.trainers)
        .doc(uid)
        .get();

    if (clientsSnapshot.exists) {
      return UserType.client;
    } else if (trainersSnapshot.exists) {
      return UserType.trainer;
    } else {
      return null;
    }
  }

  Future<bool> isNicknameUnique(String nickname) async {
    final QuerySnapshot trainerSnapshot = await FirebaseFirestore.instance
        .collection(CollectionName.trainers)
        .where(UserDocumentFields.nickname, isEqualTo: nickname)
        .get();

    final QuerySnapshot clientSnapshot = await FirebaseFirestore.instance
        .collection(CollectionName.trainers)
        .where(UserDocumentFields.nickname, isEqualTo: nickname)
        .get();
    return trainerSnapshot.docs.isEmpty && clientSnapshot.docs.isEmpty;
  }
}
