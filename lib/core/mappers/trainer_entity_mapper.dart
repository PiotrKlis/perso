import 'package:algoliasearch/src/model/hit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:perso/core/extensions/string_extensions.dart';
import 'package:perso/core/models/review_entity.dart';
import 'package:perso/core/models/trainer_entity.dart';
import 'package:perso/data/utils/firestore_constants.dart';

@injectable
class TrainerEntityMapper {
  TrainerEntity mapQuerySnapshot(QueryDocumentSnapshot<Object?> data) {
    return TrainerEntity(
      id: data[UserDocumentFields.id] as String,
      name: data[UserDocumentFields.name] as String,
      surname: data[UserDocumentFields.surname] as String,
      nickname: data[UserDocumentFields.nickname] as String,
      votesNumber: data[UserDocumentFields.votesNumber] as int,
      longBio: data[UserDocumentFields.fullBio] as String,
      shortBio: data[UserDocumentFields.shortBio] as String,
      rating: _mapRating(data[UserDocumentFields.rating]),
      address: data[UserDocumentFields.address] as String,
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

  TrainerEntity mapDocumentSnapshot(DocumentSnapshot<Object?> data) {
    return TrainerEntity(
      id: data[UserDocumentFields.id] as String,
      name: data[UserDocumentFields.name] as String,
      surname: data[UserDocumentFields.surname] as String,
      nickname: data[UserDocumentFields.nickname] as String,
      votesNumber: data[UserDocumentFields.votesNumber] as int,
      longBio: data[UserDocumentFields.fullBio] as String,
      shortBio: data[UserDocumentFields.shortBio] as String,
      rating: _mapRating(data[UserDocumentFields.rating]),
      address: data[UserDocumentFields.address] as String,
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

  TrainerEntity mapStream(Map<String, dynamic> data) {
    return TrainerEntity(
      id: data[UserDocumentFields.id] as String,
      name: data[UserDocumentFields.name] as String,
      surname: data[UserDocumentFields.surname] as String,
      nickname: data[UserDocumentFields.nickname] as String,
      votesNumber: data[UserDocumentFields.votesNumber] as int,
      longBio: data[UserDocumentFields.fullBio] as String,
      shortBio: data[UserDocumentFields.shortBio] as String,
      rating: _mapRating(data[UserDocumentFields.rating]),
      address: data[UserDocumentFields.address] as String,
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

  List<ReviewEntity> _getReviews(List<dynamic> reviews) {
    return reviews.map<ReviewEntity>((review) {
      return ReviewEntity(
        rating: _mapRating(review[UserDocumentFields.rating]),
        description: review[UserDocumentFields.description] as String,
      );
    }).toList();
  }

  TrainerEntity mapSearchResult(Hit data) {
    return TrainerEntity(
      id: data[UserDocumentFields.id] as String,
      name: data[UserDocumentFields.name] as String,
      surname: data[UserDocumentFields.surname] as String,
      nickname: data[UserDocumentFields.nickname] as String,
      votesNumber: data[UserDocumentFields.votesNumber] as int,
      longBio: data[UserDocumentFields.fullBio] as String,
      shortBio: data[UserDocumentFields.shortBio] as String,
      rating: _mapRating(data[UserDocumentFields.rating]),
      address: data[UserDocumentFields.address] as String,
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

  double _mapRating(dynamic rating) {
    if (rating is int) {
      return rating.toDouble(); // Convert int to double
    } else {
      return rating as double; // Already a double
    }
  }
}
