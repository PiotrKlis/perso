import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:perso/app/models/editable_trainer_data.dart';
import 'package:perso/core/dependency_injection/get_it.dart';
import 'package:perso/core/extensions/date_time_extensions.dart';
import 'package:perso/core/models/trainer_entity.dart';
import 'package:perso/core/models/user_session_model.dart';
import 'package:perso/core/models/user_type.dart';
import 'package:perso/data/trainers/trainers_service/trainers_service.dart';
import 'package:perso/data/utils/firestore_constants.dart';

@injectable
class FirestoreTrainersService implements TrainersService {
  final _userSessionModel = getIt.get<UserSessionModel>();

  @override
  Future<void> updateData(EditableTrainerData trainerData) async {
    try {
      final serverImagePath = await _uploadImage(trainerData.imagePath ?? '');
      final id = _userSessionModel.firebaseUser?.uid;
      await FirebaseFirestore.instance
          .collection(CollectionName.users)
          .doc(id)
          .update({
        UserDocumentFields.longBio: trainerData.longBio,
        UserDocumentFields.languages: trainerData.languages,
        UserDocumentFields.address: trainerData.address,
        UserDocumentFields.name: trainerData.name,
        UserDocumentFields.nickname: trainerData.nickname,
        UserDocumentFields.shortBio: trainerData.shortBio,
        UserDocumentFields.surname: trainerData.surname,
        UserDocumentFields.categories: trainerData.categories,
        UserDocumentFields.userType: UserType.trainer.name,
        UserDocumentFields.imagePath: serverImagePath,
        UserDocumentFields.latLng: trainerData.latLng?.toJson(),
      });
      return Future.value();
    } catch (error) {
      //TODO: Add error handling
      return Future.error(error);
    }
  }

  @override
  Future<void> uploadFullTrainerData(TrainerEntity trainerEntity) async {
    try {
      final serverImagePath = await _uploadImage(trainerEntity.imagePath);
      final id = _userSessionModel.firebaseUser?.uid;
      await FirebaseFirestore.instance
          .collection(CollectionName.users)
          .doc(id)
          .set({
        UserDocumentFields.longBio: trainerEntity.longBio,
        UserDocumentFields.languages: trainerEntity.languages,
        UserDocumentFields.address: trainerEntity.address,
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
        UserDocumentFields.pendingClients: trainerEntity.pendingClients,
        UserDocumentFields.activeClients: trainerEntity.activeClients,
        UserDocumentFields.inactiveClients: trainerEntity.inactiveClients,
        UserDocumentFields.imagePath: serverImagePath,
        UserDocumentFields.latLng: trainerEntity.latLng.toJson(),
      });
    } catch (error) {
      //TODO: Add error handling
      return Future.error(error);
    }
  }

  Future<String> _uploadImage(String path) async {
    try {
      if (path.isNotEmpty) {
        final id = _userSessionModel.firebaseUser?.uid;
        final storageReference = FirebaseStorage.instance
            .ref()
            .child('${CollectionName.images}/$id/}');
        await _deleteAlreadyPresentImage(storageReference);
        await storageReference.putFile(File(path));
        return storageReference.getDownloadURL();
      } else {
        return '';
      }
    } catch (error) {
      //TODO: Add error handling
      return Future.error(error);
    }
  }

  Future<void> _deleteAlreadyPresentImage(Reference storageReference) async {
    final files = await storageReference.list();
    if (files.items.isNotEmpty) {
      await Future.wait(files.items.map((Reference ref) => ref.delete()));
    }
  }

  @override
  Future<void> activateClient(String clientId) async {
    final trainerId = _userSessionModel.firebaseUser?.uid;
    await FirebaseFirestore.instance
        .collection(CollectionName.users)
        .doc(trainerId)
        .update({
      UserDocumentFields.pendingClients: FieldValue.arrayRemove([clientId]),
      UserDocumentFields.activeClients: FieldValue.arrayUnion([clientId]),
      UserDocumentFields.inactiveClients: FieldValue.arrayRemove([clientId]),
    });

    await FirebaseFirestore.instance
        .collection(CollectionName.users)
        .doc(clientId)
        .update({
      UserDocumentFields.pendingTrainers: FieldValue.arrayRemove([trainerId]),
      UserDocumentFields.activeTrainers: FieldValue.arrayUnion([trainerId]),
      UserDocumentFields.inactiveTrainers: FieldValue.arrayRemove([trainerId]),
    });
  }

  @override
  Future<void> deactivateClient(String clientId) async {
    final trainerId = _userSessionModel.firebaseUser?.uid;
    await FirebaseFirestore.instance
        .collection(CollectionName.users)
        .doc(trainerId)
        .update({
      UserDocumentFields.inactiveClients: FieldValue.arrayUnion([clientId]),
      UserDocumentFields.activeClients: FieldValue.arrayRemove([clientId]),
    });

    await FirebaseFirestore.instance
        .collection(CollectionName.users)
        .doc(clientId)
        .update({
      UserDocumentFields.inactiveTrainers: FieldValue.arrayUnion([trainerId]),
      UserDocumentFields.activeTrainers: FieldValue.arrayRemove([trainerId]),
    });
  }

  @override
  Future<void> removeClient(String clientId) async {
    final trainerId = _userSessionModel.firebaseUser?.uid;
    await FirebaseFirestore.instance
        .collection(CollectionName.users)
        .doc(trainerId)
        .update({
      UserDocumentFields.pendingClients: FieldValue.arrayRemove([clientId]),
      UserDocumentFields.inactiveClients: FieldValue.arrayRemove([clientId]),
    });

    await FirebaseFirestore.instance
        .collection(CollectionName.users)
        .doc(clientId)
        .update({
      UserDocumentFields.pendingTrainers: FieldValue.arrayRemove([trainerId]),
      UserDocumentFields.inactiveTrainers: FieldValue.arrayRemove([trainerId]),
    });
  }

  Future<void> addReview(String review, String trainerId, double rating) async {
    final userId = _userSessionModel.firebaseUser!.uid;
    await FirebaseFirestore.instance
        .collection(CollectionName.users)
        .doc(trainerId)
        .collection(CollectionName.reviews)
        .doc(userId)
        .set({
      UserDocumentFields.sentDate: DateTime.now().yearMonthDayFormat,
      UserDocumentFields.review: review,
      UserDocumentFields.rating: rating,
    });
  }
}
