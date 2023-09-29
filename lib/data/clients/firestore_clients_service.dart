import 'dart:io';

import 'package:Perso/app/models/client_data.dart';
import 'package:Perso/core/dependency_injection/get_it_config.dart';
import 'package:Perso/core/user_type.dart';
import 'package:Perso/data/clients/clients_service.dart';
import 'package:Perso/data/user_info/user_info_provider.dart';
import 'package:Perso/data/utils/firestore_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';

@injectable
class FirestoreClientsService implements ClientsService {
  final UserInfoProvider _userInfoProvider = getIt.get<UserInfoProvider>();

  @override
  Future<void> uploadData(ClientData clientData) async {
    try {
      await FirebaseFirestore.instance
          .collection(CollectionName.users)
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .set({
        UserDocumentFields.email: _userInfoProvider.user?.email,
        UserDocumentFields.location: clientData.location,
        UserDocumentFields.name: clientData.name,
        UserDocumentFields.nickname: clientData.nickname,
        UserDocumentFields.surname: clientData.surname,
        UserDocumentFields.userType: UserType.client.name,
      });
      return Future.value();
    } catch (error) {
      //TODO: Add error handling
      return Future.error(error);
    }
  }

  //TODO: Restrict weight of the photo on the firebase storage side
  @override
  Future<void> uploadPhoto(String path) async {
    try {
      final String? id = FirebaseAuth.instance.currentUser?.uid;
      final Reference storageReference = FirebaseStorage.instance
          .ref()
          .child("${CollectionName.images}/$id/}");
      await deleteAlreadyPresentImage(storageReference);
      await storageReference.putFile(File(path));
    } catch (error) {
      //TODO: Add error handling
      return Future.error(error);
    }
  }

  Future<void> deleteAlreadyPresentImage(Reference storageReference) async {
    ListResult files = await storageReference.list();
    if (files.items.isNotEmpty) {
      await Future.wait(files.items.map((Reference ref) => ref.delete()));
    }
  }
}
