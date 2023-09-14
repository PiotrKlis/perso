import 'dart:io';

import 'package:Perso/app/models/client_data.dart';
import 'package:Perso/core/user_type.dart';
import 'package:Perso/data/clients/clients_service.dart';
import 'package:Perso/data/utils/firestore_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';

@injectable
class FirestoreClientsService implements ClientsService {
  @override
  Future<void> uploadData(ClientData clientData) async {
    await FirebaseFirestore.instance
        .collection(CollectionName.users)
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .set({
      UserDocumentFields.email: FirebaseAuth.instance.currentUser?.email,
      UserDocumentFields.location: clientData.location,
      UserDocumentFields.name: clientData.name,
      UserDocumentFields.nickname: clientData.nickname,
      UserDocumentFields.phoneNumber: clientData.phoneNumber,
      UserDocumentFields.surname: clientData.surname,
      UserDocumentFields.userType: UserType.client.name
    });
    return Future.value();
  }

  //TODO: Restrict weight of the photo on the firebase storage side
  @override
  Future<void> uploadPhoto(String path) async {
    final String? id = FirebaseAuth.instance.currentUser?.uid;
    final Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('${CollectionName.images}/$id/$path}');
    try {
      final TaskSnapshot snapshot = await storageReference.putFile(File(path));
      final String url = await snapshot.ref.getDownloadURL();
      await FirebaseFirestore.instance
          .collection(CollectionName.users)
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .set({UserDocumentFields.image: url});
    } catch (error) {
      //TODO: Add error handling
      return Future.error(error);
    }
  }
}
