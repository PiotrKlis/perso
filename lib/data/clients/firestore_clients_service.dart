import 'package:Perso/app/models/client_data.dart';
import 'package:Perso/data/clients/clients_service.dart';
import 'package:Perso/data/utils/firestore_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@injectable
class FirestoreClientsService implements ClientsService {
  @override
  Future<void> uploadData(ClientData clientData) async {
    await FirebaseFirestore.instance
        .collection(CollectionName.clients)
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .set({
      UserDocumentFields.email: FirebaseAuth.instance.currentUser?.email,
      UserDocumentFields.location: clientData.location,
      UserDocumentFields.name: clientData.name,
      UserDocumentFields.nickname: clientData.nickname,
      UserDocumentFields.phoneNumber: clientData.phoneNumber,
      UserDocumentFields.surname: clientData.surname,
    });
    return Future.value();
  }
}
