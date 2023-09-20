import 'dart:io';

import 'package:Perso/app/models/trainer_card/trainer_entity.dart';
import 'package:Perso/app/models/trainer_data.dart';
import 'package:Perso/core/user_type.dart';
import 'package:Perso/data/trainers/trainers_service.dart';
import 'package:Perso/data/user_info/user_info_provider.dart';
import 'package:Perso/data/utils/firestore_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

@injectable
class FirestoreTrainersService implements TrainersService {
  final UserInfoProvider _userInfoProvider = GetIt.I.get<UserInfoProvider>();

  @override
  Future<void> updateData(TrainerData trainerData) async {
    await FirebaseFirestore.instance
        .collection(CollectionName.users)
        .doc(_userInfoProvider.user?.uid)
        .set({
      UserDocumentFields.email: _userInfoProvider.user?.email,
      UserDocumentFields.fullBio: trainerData.fullBio,
      UserDocumentFields.languages: trainerData.languages,
      UserDocumentFields.location: trainerData.location,
      UserDocumentFields.name: trainerData.name,
      UserDocumentFields.nickname: trainerData.nickname,
      UserDocumentFields.phoneNumber: trainerData.phoneNumber,
      UserDocumentFields.shortBio: trainerData.shortBio,
      UserDocumentFields.surname: trainerData.surname,
      UserDocumentFields.image: trainerData.imagePath,
      UserDocumentFields.categories: trainerData.categories
    });
    return Future.value();
  }

  @override
  Future<void> setData(TrainerEntity trainerEntity) async {
    await FirebaseFirestore.instance
        .collection(CollectionName.users)
        .doc(_userInfoProvider.user?.uid)
        .set({
      UserDocumentFields.email: trainerEntity.email,
      UserDocumentFields.fullBio: trainerEntity.fullBio,
      UserDocumentFields.languages: trainerEntity.languages,
      UserDocumentFields.location: trainerEntity.location,
      UserDocumentFields.name: trainerEntity.name,
      UserDocumentFields.nickname: trainerEntity.nickname,
      UserDocumentFields.phoneNumber: trainerEntity.phoneNumber,
      UserDocumentFields.shortBio: trainerEntity.shortBio,
      UserDocumentFields.surname: trainerEntity.surname,
      UserDocumentFields.id: trainerEntity.id,
      UserDocumentFields.image: trainerEntity.image,
      UserDocumentFields.votesNumber: trainerEntity.votesNumber,
      UserDocumentFields.rating: trainerEntity.rating,
      UserDocumentFields.reviews: trainerEntity.reviews,
      UserDocumentFields.categories: trainerEntity.categories,
      UserDocumentFields.userType: UserType.trainer.name
    });
    return Future.value();
  }

  @override
  Future<void> uploadPhoto(String path) async {
    final String? id = _userInfoProvider.user?.uid;
    final Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('${CollectionName.images}/$id/$path}');
    try {
      final TaskSnapshot snapshot = await storageReference.putFile(File(path));
      final String url = await snapshot.ref.getDownloadURL();
      await FirebaseFirestore.instance
          .collection(CollectionName.users)
          .doc(_userInfoProvider.user?.uid)
          .set({UserDocumentFields.image: url});
    } catch (error) {
      //TODO: Add error handling
      return Future.error(error);
    }
  }
}
