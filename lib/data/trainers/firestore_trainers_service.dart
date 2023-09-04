import 'package:Perso/app/models/trainer_data.dart';
import 'package:Perso/data/trainers/trainers_service.dart';
import 'package:Perso/data/utils/firestore_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@injectable
class FirestoreTrainersService implements TrainersService {
  @override
  Future<void> uploadData(TrainerData trainerData) {
    FirebaseFirestore.instance
        .collection(CollectionName.trainers)
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .set({
      "email": FirebaseAuth.instance.currentUser?.email,
      "fullBio": trainerData.fullBio,
      "languages": trainerData.languageFlags,
      "location": trainerData.location,
      "name": trainerData.name,
      "nickname": trainerData.nickname,
      "phoneNumber": trainerData.phoneNumber,
      "shortBio": trainerData.shortBio,
      "surname": trainerData.surname,
    });
    return Future.value();
  }
}
