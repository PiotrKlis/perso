import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:perso/core/models/client_entity.dart';
import 'package:perso/core/string_extensions.dart';
import 'package:perso/data/clients/clients_provider/clients_source.dart';
import 'package:perso/data/utils/firestore_constants.dart';

@injectable
class FirestoreClientsProvider implements ClientsSource {
  @override
  Future<ClientEntity> getClientData(String id) async {
    final DocumentSnapshot clientsSnapshot = await FirebaseFirestore.instance
        .collection(CollectionName.users)
        .doc(id)
        .get();

    final data = clientsSnapshot.data()! as Map<String, dynamic>;
    return ClientEntity(
      id: id,
      name: data[UserDocumentFields.name] as String,
      surname: data[UserDocumentFields.surname] as String,
      nickname: data[UserDocumentFields.nickname] as String,
      imagePath: data[UserDocumentFields.imagePath] as String,
      languages: data[UserDocumentFields.languages]
          .toString()
          .removeBrackets()
          .split(', '),
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
    );
  }
}
