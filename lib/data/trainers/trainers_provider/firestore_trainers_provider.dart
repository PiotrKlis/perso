import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:perso/core/dependency_injection/get_it.dart';
import 'package:perso/core/models/review_entity.dart';
import 'package:perso/core/models/trainer_entity.dart';
import 'package:perso/core/string_extensions.dart';
import 'package:perso/core/models/user_type.dart';
import 'package:perso/data/trainers/trainers_provider/trainers_source.dart';
import 'package:perso/data/user_info/user_info_provider.dart';
import 'package:perso/data/utils/firestore_constants.dart';

@injectable
class FirestoreTrainersProvider implements TrainersSource {
  final userInfoProvider = getIt.get<UserInfoProvider>();

  @override
  Future<List<TrainerEntity>> getAllTrainersData() async {
    final QuerySnapshot trainersSnapshot = await FirebaseFirestore.instance
        .collection(CollectionName.trainers)
        .get();

    return trainersSnapshot.docs.map((data) {
      return TrainerEntity(
        id: data.id,
        name: data[UserDocumentFields.name] as String,
        surname: data[UserDocumentFields.surname] as String,
        nickname: data[UserDocumentFields.nickname] as String,
        votesNumber: data[UserDocumentFields.votesNumber] as int,
        shortBio: data[UserDocumentFields.shortBio] as String,
        rating: data[UserDocumentFields.rating] as double,
        languages: data[UserDocumentFields.languages].toString().split(', '),
        categories: data[UserDocumentFields.categories]
            .toString()
            .removeBrackets()
            .split(', '),
        imagePath: data[UserDocumentFields.imagePath] as String,
        fullBio: data[UserDocumentFields.fullBio] as String,
        location: data[UserDocumentFields.location] as String,
        reviews: _getReviews(data[UserDocumentFields.reviews] as List<dynamic>),
        pendingClients:
            data[UserDocumentFields.pendingClients].toString().split(', '),
        activeClients:
            data[UserDocumentFields.activeClients].toString().split(', '),
        inactiveClients:
            data[UserDocumentFields.inactiveClients].toString().split(', '),
        latLng: LatLng.fromJson(data[UserDocumentFields.latLng]) ??
            const LatLng(0, 0),
      );
    }).toList();
  }

  List<ReviewEntity> _getReviews(List<dynamic> reviews) {
    return reviews.map<ReviewEntity>((review) {
      return ReviewEntity(
        rating: review[UserDocumentFields.rating] as double,
        description: review[UserDocumentFields.description] as String,
      );
    }).toList();
  }

  //TODO: Refactor into future?
  @override
  Stream<TrainerEntity> getTrainerData(String id) async* {
    final snapshots = FirebaseFirestore.instance
        .collection(CollectionName.trainers)
        .doc(id)
        .snapshots();

    await for (final snapshot in snapshots) {
      final data = snapshot.data()!;
      yield TrainerEntity(
        id: data[UserDocumentFields.id] as String,
        name: data[UserDocumentFields.name] as String,
        surname: data[UserDocumentFields.surname] as String,
        nickname: data[UserDocumentFields.nickname] as String,
        votesNumber: data[UserDocumentFields.votesNumber] as int,
        fullBio: data[UserDocumentFields.fullBio] as String,
        shortBio: data[UserDocumentFields.shortBio] as String,
        rating: data[UserDocumentFields.rating] as double,
        location: data[UserDocumentFields.location] as String,
        reviews: _getReviews(data[UserDocumentFields.reviews] as List<dynamic>),
        languages: data[UserDocumentFields.languages]
            .toString()
            .removeBrackets()
            .split(', '),
        categories: data[UserDocumentFields.categories]
            .toString()
            .removeBrackets()
            .split(', '),
        pendingClients: data[UserDocumentFields.pendingClients]
            .toString()
            .removeBrackets()
            .split(', '),
        activeClients: data[UserDocumentFields.activeClients]
            .toString()
            .removeBrackets()
            .split(', '),
        inactiveClients: data[UserDocumentFields.inactiveClients]
            .toString()
            .removeBrackets()
            .split(', '),
        imagePath: data[UserDocumentFields.imagePath] as String,
        latLng: LatLng.fromJson(data[UserDocumentFields.latLng]) ??
            const LatLng(0, 0),
      );
    }
  }

  @override
  Future<List<String>> getSpecialities(String id) async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection(CollectionName.trainers)
        .where(UserDocumentFields.id, isEqualTo: id)
        .get();

    final categories = snapshot.docs.first[UserDocumentFields.categories]
        .toString()
        .removeBrackets()
        .split(', ');
    return categories;
  }
}
