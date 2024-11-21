import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:perso/core/dependency_injection/get_it.dart';
import 'package:perso/core/mappers/client_entity_mapper.dart';
import 'package:perso/core/models/client_entity.dart';
import 'package:perso/data/clients/clients_provider/clients_source.dart';
import 'package:perso/data/utils/firestore_constants.dart';

@injectable
class FirestoreClientsProvider implements ClientsSource {
  final clientEntityMapper = getIt.get<ClientEntityMapper>();

  @override
  Future<ClientEntity> getClientData(String id) async {
    final DocumentSnapshot clientsSnapshot = await FirebaseFirestore.instance
        .collection(CollectionName.users)
        .doc(id)
        .get();

    return clientEntityMapper.mapDocumentSnapshot(clientsSnapshot);
  }
}
