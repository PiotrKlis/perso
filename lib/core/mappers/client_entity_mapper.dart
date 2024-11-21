import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:perso/core/extensions/string_extensions.dart';
import 'package:perso/core/models/client_entity.dart';
import 'package:perso/core/models/user_type.dart';
import 'package:perso/data/utils/firestore_constants.dart';

@injectable
class ClientEntityMapper {
  ClientEntity mapDocumentSnapshot(DocumentSnapshot<Object?> clientsSnapshot) {
    final data = clientsSnapshot.data()! as Map<String, dynamic>;
    return ClientEntity(
      id: data[UserDocumentFields.id] as String,
      name: data[UserDocumentFields.name] as String,
      surname: data[UserDocumentFields.surname] as String,
      nickname: data[UserDocumentFields.nickname] as String,
      imagePath: data[UserDocumentFields.imagePath] as String,
      pendingTrainers: data[UserDocumentFields.pendingTrainers]
          .toString()
          .removeBrackets()
          .split(', '),
      activeTrainers: data[UserDocumentFields.activeTrainers]
          .toString()
          .removeBrackets()
          .split(', '),
      inactiveTrainers: data[UserDocumentFields.inactiveTrainers]
          .toString()
          .removeBrackets()
          .split(', '),
      userType: UserType.client,
    );
  }
}
