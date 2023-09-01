import 'package:Perso/data/clients/clients_service.dart';
import 'package:injectable/injectable.dart';

@injectable
class FirestoreClientsService implements ClientsService {
  @override
  Future<void> manageData() {
    //TODO: Send data to firestore
    return Future.value();
  }
}
