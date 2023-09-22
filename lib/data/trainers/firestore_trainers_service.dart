import 'dart:io';

import 'package:Perso/app/models/trainer_card/trainer_entity.dart';
import 'package:Perso/app/models/trainer_data.dart';
import 'package:Perso/core/dependency_injection/get_it_config.dart';
import 'package:Perso/core/user_type.dart';
import 'package:Perso/data/shared_prefs/perso_shared_prefs.dart';
import 'package:Perso/data/trainers/trainers_service.dart';
import 'package:Perso/data/user_info/user_info_provider.dart';
import 'package:Perso/data/utils/firestore_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';

@injectable
class FirestoreTrainersService implements TrainersService {
  final UserInfoProvider _userInfoProvider = getIt.get<UserInfoProvider>();
  final PersoSharedPrefs _persoSharedPrefs = getIt.get<PersoSharedPrefs>();

  @override
  Future<void> updateData(TrainerData trainerData) async {
    try {
      await FirebaseFirestore.instance
          .collection(CollectionName.users)
          .doc(trainerData.nickname)
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
      await _persoSharedPrefs.setString(
          PersoSharedPrefs.userNicknameKey, trainerData.nickname);
      return Future.value();
    } catch (error) {
      //TODO: Add error handling
      return Future.error(error);
    }
  }

  @override
  Future<void> setData(TrainerEntity trainerEntity) async {
    try {
      await FirebaseFirestore.instance
          .collection(CollectionName.users)
          .doc(trainerEntity.nickname)
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
    } catch (error) {
      //TODO: Add error handling
      return Future.error(error);
    }
  }

  @override
  Future<void> uploadPhoto(String path) async {
    try {
      final String nickname =
          _persoSharedPrefs.getString(PersoSharedPrefs.userNicknameKey);
      final Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('${CollectionName.images}/$nickname/}');
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
