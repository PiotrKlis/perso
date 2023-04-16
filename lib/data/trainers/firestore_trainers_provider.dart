import 'package:Perso/app/models/trainer_card/review_entity.dart';
import 'package:Perso/app/models/trainer_card/trainer_entity.dart';
import 'package:Perso/data/trainers/trainers_source.dart';
import 'package:Perso/data/utils/firestore_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@injectable
class FirestoreTrainersProvider implements TrainersSource {
  @override
  Future<List<TrainerEntity>> getTrainers() async {
    final QuerySnapshot trainersSnapshot = await FirebaseFirestore.instance
        .collection(CollectionName.trainers)
        .get();
    return trainersSnapshot.docs.map((data) {
      return TrainerEntity(
          id: data.id,
          name: data[TrainerDocumentFields.name],
          surname: data[TrainerDocumentFields.surname],
          nickname: data[TrainerDocumentFields.nickname],
          votesNumber: data[TrainerDocumentFields.votesNumber],
          fullBio: data[TrainerDocumentFields.fullBio],
          shortBio: data[TrainerDocumentFields.shortBio],
          icon: "assets/images/trainer3.png",
          email: "",
          rating: 2.3,
          location: data[TrainerDocumentFields.location],
          phoneNumber: data[TrainerDocumentFields.phoneNumber],
          languages:
              data[TrainerDocumentFields.languages].toString().split(", "),
          reviews: getReviews(data),
          trainingTypes:
              data[TrainerDocumentFields.trainingTypes].toString().split(", "));
    }).toList();
  }

  List<ReviewEntity> getReviews(QueryDocumentSnapshot<Object?> data) {
    return data[TrainerDocumentFields.reviews].map<ReviewEntity>((review) {
      return ReviewEntity(
          rating: review[TrainerDocumentFields.rating],
          description: review[TrainerDocumentFields.description]);
    }).toList();
  }
}
