import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:perso/app/models/editable_client_data.dart';
import 'package:perso/core/models/client_entity.dart';
import 'package:perso/core/user_type.dart';
import 'package:perso/data/clients/clients_service/clients_service.dart';
import 'package:perso/data/utils/firestore_constants.dart';

@injectable
class FirestoreClientsService implements ClientsService {
  @override
  Future<void> uploadFullClientData(ClientEntity clientEntity) async {
    final serverImagePath = await _uploadImage(clientEntity.imagePath);
    await FirebaseFirestore.instance
        .collection(CollectionName.users)
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .set({
      UserDocumentFields.name: clientEntity.name,
      UserDocumentFields.nickname: clientEntity.nickname,
      UserDocumentFields.surname: clientEntity.surname,
      UserDocumentFields.userType: UserType.client.name,
      UserDocumentFields.imagePath: serverImagePath,
      UserDocumentFields.languages: clientEntity.languages,
      UserDocumentFields.activeTrainers: clientEntity.activeTrainers,
      UserDocumentFields.pendingRequests: clientEntity.pendingRequests,
      UserDocumentFields.inactiveTrainers: clientEntity.inactiveTrainers,
    });
    return Future.value();
  }

  @override
  Future<void> updateData(EditableClientData editableClientData) async {
    final serverImagePath = await _uploadImage(editableClientData.imagePath);
    await FirebaseFirestore.instance
        .collection(CollectionName.users)
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .update({
      UserDocumentFields.name: editableClientData.name,
      UserDocumentFields.nickname: editableClientData.nickname,
      UserDocumentFields.surname: editableClientData.surname,
      UserDocumentFields.userType: UserType.client.name,
      UserDocumentFields.imagePath: serverImagePath,
      UserDocumentFields.languages: editableClientData.languages,
    });
  }

  //TODO: Restrict weight of the photo on the firebase storage side
  Future<String> _uploadImage(String path) async {
    if (path.isNotEmpty) {
      final id = FirebaseAuth.instance.currentUser?.uid;
      final storageReference = FirebaseStorage.instance
          .ref()
          .child('${CollectionName.images}/$id/}');
      await _deleteAlreadyPresentImage(storageReference);
      await storageReference.putFile(File(path));
      final files = await storageReference.list();
      return files.items.first.fullPath;
    } else {
      return '';
    }
  }

  Future<void> _deleteAlreadyPresentImage(Reference storageReference) async {
    final files = await storageReference.list();
    if (files.items.isNotEmpty) {
      await Future.wait(files.items.map((Reference ref) => ref.delete()));
    }
  }
}
