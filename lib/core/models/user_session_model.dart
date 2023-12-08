import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:perso/core/user_type.dart';

@Singleton(order: -1)
class UserSessionModel {
  User? user;
  bool isProfileCreated = false;
  UserType? userType;
  bool isEmailVerified = false;

  bool get isUserLoggedIn =>
      user != null && userType != null && isProfileCreated && isEmailVerified;

  Future<void> update({
    required User user,
    required UserType? userType,
    required bool isProfileCreated,
    required bool isEmailVerified,
  }) async {
    this.user = user;
    this.userType = userType;
    this.isProfileCreated = isProfileCreated;
    this.isEmailVerified = isEmailVerified;
  }

  void reset() {
    user = null;
    userType = null;
    isProfileCreated = false;
    isEmailVerified = false;
  }
}
