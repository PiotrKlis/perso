import 'package:Perso/app/models/trainer_card/review_entity.dart';
import 'package:Perso/app/models/trainer_card/trainer_entity.dart';
import 'package:Perso/core/user_type.dart';
import 'package:Perso/data/trainers/trainers_source.dart';
import 'package:Perso/data/utils/firestore_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@injectable
class FirestoreTrainersProvider implements TrainersSource {
  @override
  Future<List<TrainerEntity>> getTrainers() async {
    final QuerySnapshot trainersSnapshot = await FirebaseFirestore.instance
        .collection(CollectionName.users)
        .where(UserDocumentFields.userType, isEqualTo: UserType.trainer.name)
        .get();
    return trainersSnapshot.docs.map((data) {
      return TrainerEntity(
          id: data.id,
          name: data[UserDocumentFields.name],
          surname: data[UserDocumentFields.surname],
          nickname: data[UserDocumentFields.nickname],
          votesNumber: data[UserDocumentFields.votesNumber],
          fullBio: data[UserDocumentFields.fullBio],
          shortBio: data[UserDocumentFields.shortBio],
          image: "assets/images/trainer3.png",
          email: "",
          rating: 2.3,
          location: data[UserDocumentFields.location],
          phoneNumber: data[UserDocumentFields.phoneNumber],
          languages: data[UserDocumentFields.languages].toString().split(", "),
          reviews: _getReviews(data),
          categories:
              data[UserDocumentFields.categories].toString().split(", "));
    }).toList();
  }

  List<ReviewEntity> _getReviews(QueryDocumentSnapshot<Object?> data) {
    return data[UserDocumentFields.reviews].map<ReviewEntity>((review) {
      return ReviewEntity(
          rating: review[UserDocumentFields.rating],
          description: review[UserDocumentFields.description]);
    }).toList();
  }
}
