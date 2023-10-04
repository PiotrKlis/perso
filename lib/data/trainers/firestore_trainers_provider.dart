import 'package:Perso/core/models/review_entity.dart';
import 'package:Perso/core/models/trainer_entity.dart';
import 'package:Perso/core/models/trainer_short_data.dart';
import 'package:Perso/core/user_type.dart';
import 'package:Perso/data/trainers/trainers_source.dart';
import 'package:Perso/data/utils/firestore_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@injectable
class FirestoreTrainersProvider implements TrainersSource {
  @override
  Future<List<TrainerShortData>> getAllTrainersShortData() async {
    final QuerySnapshot trainersSnapshot = await FirebaseFirestore.instance
        .collection(CollectionName.users)
        .where(UserDocumentFields.userType, isEqualTo: UserType.trainer.name)
        .get();

    return trainersSnapshot.docs.map((data) {
      return TrainerShortData(
          id: data.id,
          name: data[UserDocumentFields.name],
          surname: data[UserDocumentFields.surname],
          nickname: data[UserDocumentFields.nickname],
          votesNumber: data[UserDocumentFields.votesNumber],
          shortBio: data[UserDocumentFields.shortBio],
          rating: data[UserDocumentFields.rating],
          languages: data[UserDocumentFields.languages].toString().split(", "),
          categories:
              data[UserDocumentFields.categories].toString().split(", "),
          imagePath: data[UserDocumentFields.imagePath]);
    }).toList();
  }

  List<ReviewEntity> _getReviews(QueryDocumentSnapshot<Object?> data) {
    return data[UserDocumentFields.reviews].map<ReviewEntity>((review) {
      return ReviewEntity(
          rating: review[UserDocumentFields.rating],
          description: review[UserDocumentFields.description]);
    }).toList();
  }

  @override
  Future<TrainerEntity> getTrainerData(String id) async {
    final QuerySnapshot trainersSnapshot = await FirebaseFirestore.instance
        .collection(CollectionName.users)
        .where(UserDocumentFields.id, isEqualTo: id)
        .get();
    final data = trainersSnapshot.docs.first;
    return TrainerEntity(
        id: data.id,
        name: data[UserDocumentFields.name],
        surname: data[UserDocumentFields.surname],
        nickname: data[UserDocumentFields.nickname],
        votesNumber: data[UserDocumentFields.votesNumber],
        fullBio: data[UserDocumentFields.fullBio],
        shortBio: data[UserDocumentFields.shortBio],
        rating: data[UserDocumentFields.rating],
        location: data[UserDocumentFields.location],
        reviews: _getReviews(data),
        languages: data[UserDocumentFields.languages].toString().split(", "),
        categories: data[UserDocumentFields.categories].toString().split(", "),
        pendingRequests:
            data[UserDocumentFields.pendingRequests].toString().split(", "),
        activeClients:
            data[UserDocumentFields.activeClients].toString().split(", "),
        inactiveClients:
            data[UserDocumentFields.inactiveClients].toString().split(", "),
        imagePath: data[UserDocumentFields.imagePath]);
  }
}
