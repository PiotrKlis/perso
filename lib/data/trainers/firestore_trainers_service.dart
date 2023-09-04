import 'package:Perso/app/models/trainer_data.dart';
import 'package:Perso/data/trainers/trainers_service.dart';
import 'package:Perso/data/utils/firestore_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@injectable
class FirestoreTrainersService implements TrainersService {
  @override
  Future<void> uploadData(TrainerData trainerData) async {
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
    });
    return Future.value();
  }
}
