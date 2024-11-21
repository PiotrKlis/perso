import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:perso/core/models/profile_entity.dart';
import 'package:perso/core/models/user_type.dart';

@Singleton(order: -1)
class UserSessionModel {
  User? firebaseUser;
  bool isProfileCreated = false;
  ProfileEntity? profileEntity;
  bool isEmailVerified = false;

  bool get isUserLoggedIn =>
      firebaseUser != null &&
      profileEntity != null &&
      isProfileCreated &&
      isEmailVerified;

  Future<void> update({
    required User firebaseUser,
    required UserType? userType,
    required bool isProfileCreated,
    required bool isEmailVerified,
    required ProfileEntity? profileEntity,
  }) async {
    this.firebaseUser = firebaseUser;
    this.isProfileCreated = isProfileCreated;
    this.isEmailVerified = isEmailVerified;
    this.profileEntity = profileEntity;
  }

  void reset() {
    firebaseUser = null;
    isProfileCreated = false;
    isEmailVerified = false;
    profileEntity = null;
  }
}
