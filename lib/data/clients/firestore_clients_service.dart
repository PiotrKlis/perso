import 'dart:io';

import 'package:perso/app/models/editable_client_data.dart';
import 'package:perso/core/user_type.dart';
import 'package:perso/data/clients/clients_service.dart';
import 'package:perso/data/utils/firestore_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';

@injectable
class FirestoreClientsService implements ClientsService {
  @override
  Future<void> uploadData(EditableClientData clientData) async {
    try {
      final serverImagePath = await _uploadImage(clientData.imagePath);
      await FirebaseFirestore.instance
          .collection(CollectionName.users)
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .set({
        UserDocumentFields.location: clientData.location,
        UserDocumentFields.name: clientData.name,
        UserDocumentFields.nickname: clientData.nickname,
        UserDocumentFields.surname: clientData.surname,
        UserDocumentFields.userType: UserType.client.name,
        UserDocumentFields.imagePath: serverImagePath,
        //TODO: Change below while working on client profile screen and its edit feature
        UserDocumentFields.activeTrainers: List.empty(),
        UserDocumentFields.pendingRequests: List.empty(),
        UserDocumentFields.inactiveTrainers: List.empty(),
      });
      return Future.value();
    } catch (error) {
      //TODO: Add error handling
      return Future.error(error);
    }
  }

  //TODO: Restrict weight of the photo on the firebase storage side
  Future<String> _uploadImage(String path) async {
    try {
      if (path.isNotEmpty) {
        final String? id = FirebaseAuth.instance.currentUser?.uid;
        final Reference storageReference = FirebaseStorage.instance
            .ref()
            .child('${CollectionName.images}/$id/}');
        await _deleteAlreadyPresentImage(storageReference);
        await storageReference.putFile(File(path));
        ListResult files = await storageReference.list();
        return files.items.first.fullPath;
      } else {
        return "";
      }
    } catch (error) {
      //TODO: Add error handling
      return Future.error(error);
    }
  }

  Future<void> _deleteAlreadyPresentImage(Reference storageReference) async {
    ListResult files = await storageReference.list();
    if (files.items.isNotEmpty) {
      await Future.wait(files.items.map((Reference ref) => ref.delete()));
    }
  }
}
