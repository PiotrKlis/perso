import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:perso/core/dependency_injection/get_it.dart';
import 'package:perso/core/mappers/client_entity_mapper.dart';
import 'package:perso/core/mappers/trainer_entity_mapper.dart';
import 'package:perso/core/models/profile_entity.dart';
import 'package:perso/core/models/user_session_model.dart';
import 'package:perso/core/models/user_type.dart';
import 'package:perso/data/utils/firestore_constants.dart';

@Singleton()
class UserInfoProvider {
  final _userSessionModel = getIt.get<UserSessionModel>();
  final _trainerEntityMapper = getIt.get<TrainerEntityMapper>();
  final _clientEntityMapper = getIt.get<ClientEntityMapper>();

  Future<void> updateSessionModel(User user) async {
    final snapshot = await FirebaseFirestore.instance
        .collection(CollectionName.users)
        .doc(user.uid)
        .get();

    final userType = _getUserType(snapshot);
    final profileEntity = _getProfileEntity(userType, snapshot);

    await _userSessionModel.update(
      firebaseUser: user,
      isProfileCreated: userType != null,
      userType: userType,
      isEmailVerified: user.emailVerified,
      profileEntity: profileEntity,
    );
  }

  void listenForFirebaseUserChange() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user != null) {
        await updateSessionModel(user);
      } else {
        _userSessionModel.reset();
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

  UserType? _getUserType(
    DocumentSnapshot<Map<String, dynamic>> userSnapshot,
  ) {
    if (userSnapshot.exists) {
      final userType =
          (userSnapshot[UserDocumentFields.userType] as String).toUserType();
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

  ProfileEntity _getProfileEntity(
    UserType? userType,
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    if (userType == UserType.trainer) {
      return _trainerEntityMapper.mapDocumentSnapshot(snapshot);
    } else {
      return _clientEntityMapper.mapDocumentSnapshot(snapshot);
    }
  }
}
