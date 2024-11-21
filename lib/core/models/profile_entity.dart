import 'dart:core';

import 'package:perso/core/models/user_type.dart';

abstract class ProfileEntity {
  ProfileEntity(
    this.id,
    this.name,
    this.surname,
    this.nickname,
    this.imagePath,
    this.userType,
  );

  final String id;
  final String name;
  final String surname;
  final String nickname;
  final String imagePath;
  final UserType userType;
}
