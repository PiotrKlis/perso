import 'dart:io';

import 'package:Perso/app/models/editable_trainer_data.dart';
import 'package:Perso/core/models/trainer_entity.dart';
import 'package:Perso/core/user_type.dart';
import 'package:Perso/data/trainers/trainers_service.dart';
import 'package:Perso/data/utils/firestore_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';

@injectable
class FirestoreTrainersService implements TrainersService {
  @override
  Future<void> updateData(EditableTrainerData trainerData) async {
    try {
      final serverImagePath = await _uploadImage(trainerData.imagePath);
      final String? id = FirebaseAuth.instance.currentUser?.uid;
      await FirebaseFirestore.instance
          .collection(CollectionName.users)
          .doc(id)
          .set({
        UserDocumentFields.fullBio: trainerData.fullBio,
        UserDocumentFields.languages: trainerData.languages,
        UserDocumentFields.location: trainerData.location,
        UserDocumentFields.name: trainerData.name,
        UserDocumentFields.nickname: trainerData.nickname,
        UserDocumentFields.shortBio: trainerData.shortBio,
        UserDocumentFields.surname: trainerData.surname,
        UserDocumentFields.categories: trainerData.categories,
        UserDocumentFields.userType: UserType.trainer.name,
        UserDocumentFields.imagePath: serverImagePath
      });
      return Future.value();
    } catch (error) {
      //TODO: Add error handling
      return Future.error(error);
    }
  }

  @override
  Future<void> setData(TrainerEntity trainerEntity) async {
    try {
      final serverImagePath = await _uploadImage(trainerEntity.imagePath);
      final String? id = FirebaseAuth.instance.currentUser?.uid;
      await FirebaseFirestore.instance
          .collection(CollectionName.users)
          .doc(id)
          .set({
        UserDocumentFields.fullBio: trainerEntity.fullBio,
        UserDocumentFields.languages: trainerEntity.languages,
        UserDocumentFields.location: trainerEntity.location,
        UserDocumentFields.name: trainerEntity.name,
        UserDocumentFields.nickname: trainerEntity.nickname,
        UserDocumentFields.shortBio: trainerEntity.shortBio,
        UserDocumentFields.surname: trainerEntity.surname,
        UserDocumentFields.id: trainerEntity.id,
        UserDocumentFields.votesNumber: trainerEntity.votesNumber,
        UserDocumentFields.rating: trainerEntity.rating,
        UserDocumentFields.reviews: trainerEntity.reviews,
        UserDocumentFields.categories: trainerEntity.categories,
        UserDocumentFields.userType: UserType.trainer.name,
        UserDocumentFields.pendingRequests: trainerEntity.pendingRequests,
        UserDocumentFields.activeClients: trainerEntity.activeClients,
        UserDocumentFields.inactiveClients: trainerEntity.inactiveClients,
        UserDocumentFields.imagePath: serverImagePath
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
