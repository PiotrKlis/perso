import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:perso/app/models/editable_client_data.dart';
import 'package:perso/core/dependency_injection/get_it.dart';
import 'package:perso/core/models/client_entity.dart';
import 'package:perso/core/models/user_session_model.dart';
import 'package:perso/core/models/user_type.dart';
import 'package:perso/data/clients/clients_service/clients_service.dart';
import 'package:perso/data/utils/firestore_constants.dart';

@injectable
class FirestoreClientsService implements ClientsService {
  final _userSessionModel = getIt.get<UserSessionModel>();
  @override
  Future<void> uploadFullClientData(ClientEntity clientEntity) async {
    final id = _userSessionModel.user?.uid;
    final serverImagePath = await _uploadImage(clientEntity.imagePath);
    await FirebaseFirestore.instance
        .collection(CollectionName.users)
        .doc(id)
        .set({
      UserDocumentFields.name: clientEntity.name,
      UserDocumentFields.nickname: clientEntity.nickname,
      UserDocumentFields.surname: clientEntity.surname,
      UserDocumentFields.userType: UserType.client.name,
      UserDocumentFields.imagePath: serverImagePath,
      UserDocumentFields.languages: clientEntity.languages,
      UserDocumentFields.activeTrainers: clientEntity.activeTrainers,
      UserDocumentFields.pendingTrainers: clientEntity.pendingTrainers,
      UserDocumentFields.inactiveTrainers: clientEntity.inactiveTrainers,
    });
  }

  @override
  Future<void> updateData(EditableClientData editableClientData) async {
    final id = _userSessionModel.user?.uid;
    final serverImagePath = await _uploadImage(editableClientData.imagePath);
    await FirebaseFirestore.instance
        .collection(CollectionName.users)
        .doc(id)
        .update({
      UserDocumentFields.name: editableClientData.name,
      UserDocumentFields.nickname: editableClientData.nickname,
      UserDocumentFields.surname: editableClientData.surname,
      UserDocumentFields.userType: UserType.client.name,
      UserDocumentFields.imagePath: serverImagePath,
      UserDocumentFields.languages: editableClientData.languages,
    });
  }

  Future<String> _uploadImage(String path) async {
    if (path.isNotEmpty) {
      final id = FirebaseAuth.instance.currentUser?.uid;
      final storageReference = FirebaseStorage.instance
          .ref()
          .child('${CollectionName.images}/$id/}');
      await _deleteAlreadyPresentImage(storageReference);
      await storageReference.putFile(File(path));
      return path;
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
