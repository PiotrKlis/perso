import 'package:perso/data/utils/firestore_constants.dart';

enum UserType { trainer, client }

extension StringToUserType on String {
  UserType? toUserType() {
    switch (this) {
      case 'trainer':
        return UserType.trainer;
      case 'client':
        return UserType.client;
      default:
        return null;
    }
  }
}

extension UserTypeToDocumentField on UserType {
  String toCollectionName() {
    switch (this) {
      case UserType.trainer:
        return CollectionName.trainers;
      case UserType.client:
        return CollectionName.clients;
    }
  }
}
