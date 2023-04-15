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
          icon: "",
          name: data[TrainerDocumentFields.name],
          surname: data[TrainerDocumentFields.surname],
          nickname: data[TrainerDocumentFields.nickname],
          votesNumber: data[TrainerDocumentFields.votesNumber],
          fullBio: data[TrainerDocumentFields.fullBio],
          shortBio: data[TrainerDocumentFields.shortBio],
          email: data[TrainerDocumentFields.email],
          rating: data[TrainerDocumentFields.rating].toDouble(),
          location: data[TrainerDocumentFields.location],
          phoneNumber: data[TrainerDocumentFields.phoneNumber],
          languages:
              data[TrainerDocumentFields.languages].toString().split(", "),
          reviews: [ReviewEntity(rating: 2.3, description: "description")],
          // reviews: data[TrainerDocumentFields.reviews].map((review) {
          //   double rating =
          //       review.values.firstWhere((element) => element.key == "rating");
          //   String description = review.values
          //       .firstWhere((element) => element.key == "description");
          //   return ReviewEntity(rating: rating, description: description);
          // }).toList(),
          trainingTypes:
              data[TrainerDocumentFields.trainingTypes].toString().split(", "));
    }).toList();
  }
}
