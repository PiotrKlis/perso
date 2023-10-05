import 'package:Perso/core/models/review_entity.dart';
import 'package:Perso/core/models/trainer_entity.dart';
import 'package:Perso/core/string_extensions.dart';
import 'package:Perso/core/user_type.dart';
import 'package:Perso/data/trainers/trainers_source.dart';
import 'package:Perso/data/utils/firestore_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@injectable
class FirestoreTrainersProvider implements TrainersSource {
  @override
  Future<List<TrainerEntity>> getAllTrainersData() async {
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
          shortBio: data[UserDocumentFields.shortBio],
          rating: data[UserDocumentFields.rating],
          languages: data[UserDocumentFields.languages].toString().split(", "),
          categories:
              data[UserDocumentFields.categories].toString().split(", "),
          imagePath: data[UserDocumentFields.imagePath],
          fullBio: data[UserDocumentFields.fullBio],
          location: data[UserDocumentFields.location],
          reviews: _getReviews(data[UserDocumentFields.reviews]),
          pendingRequests:
              data[UserDocumentFields.pendingRequests].toString().split(", "),
          activeClients:
              data[UserDocumentFields.activeClients].toString().split(", "),
          inactiveClients:
              data[UserDocumentFields.inactiveClients].toString().split(", "));
    }).toList();
  }

  List<ReviewEntity> _getReviews(List reviews) {
    return reviews.map<ReviewEntity>((review) {
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
        reviews: _getReviews(data[UserDocumentFields.reviews]),
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

  @override
  Future<List<String>> getSpecialities(String id) async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection(CollectionName.users)
        .where(UserDocumentFields.id, isEqualTo: id)
        .get();

    final categories = snapshot.docs.first[UserDocumentFields.categories]
        .toString()
        .removeBrackets()
        .split(", ");
    return categories;
  }
}
