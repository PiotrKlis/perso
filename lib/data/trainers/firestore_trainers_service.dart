import 'package:Perso/app/models/trainer_card/trainer_entity.dart';
import 'package:Perso/app/models/trainer_data.dart';
import 'package:Perso/data/trainers/trainers_service.dart';
import 'package:Perso/data/utils/firestore_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@injectable
class FirestoreTrainersService implements TrainersService {
  @override
  Future<void> updateData(TrainerData trainerData) async {
    await FirebaseFirestore.instance
        .collection(CollectionName.trainers)
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .set({
      UserDocumentFields.email: FirebaseAuth.instance.currentUser?.email,
      UserDocumentFields.fullBio: trainerData.fullBio,
      UserDocumentFields.languages: trainerData.languages,
      UserDocumentFields.location: trainerData.location,
      UserDocumentFields.name: trainerData.name,
      UserDocumentFields.nickname: trainerData.nickname,
      UserDocumentFields.phoneNumber: trainerData.phoneNumber,
      UserDocumentFields.shortBio: trainerData.shortBio,
      UserDocumentFields.surname: trainerData.surname,
      UserDocumentFields.image: trainerData.image,
    });
    return Future.value();
  }

  @override
  Future<void> setData(TrainerEntity trainerEntity) async {
    await FirebaseFirestore.instance
        .collection(CollectionName.trainers)
        .doc(FirebaseAuth.instance.currentUser?.uid)
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
      UserDocumentFields.trainingTypes: trainerEntity.trainingTypes,
    });
    return Future.value();
  }
}
