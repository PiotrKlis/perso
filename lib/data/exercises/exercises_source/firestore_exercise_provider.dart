import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:perso/core/models/exercise_entity.dart';
import 'package:perso/data/exercises/exercises_source/exercise_source.dart';
import 'package:perso/data/utils/firestore_constants.dart';

@injectable
class FirestoreExerciseProvider extends ExerciseSource {
  @override
  Future<List<ExerciseEntity>> getAllExercises() async {
    final exerciseSnapshots = await FirebaseFirestore.instance
        .collection(CollectionName.exercises)
        .get();

    return exerciseSnapshots.docs
        .map(
          (exercise) => ExerciseEntity(
            id: exercise[UserDocumentFields.id] as String,
            description: exercise[UserDocumentFields.description] as String,
            index: exercise[UserDocumentFields.index] as int,
            isRepsBased: exercise[UserDocumentFields.isRepsBased] as bool,
            isTimeBased: exercise[UserDocumentFields.isTimeBased] as bool,
            reps: exercise[UserDocumentFields.reps] as int,
            sets: exercise[UserDocumentFields.sets] as int,
            tags: _getTags(exercise[UserDocumentFields.tags] as List<dynamic>),
            time: exercise[UserDocumentFields.time] as String,
            title: exercise[UserDocumentFields.title] as String,
            videoId: exercise[UserDocumentFields.videoId] as String,
          ),
        )
        .toList();
  }

  @override
  Future<List<ExerciseEntity>> getExercisesForClient(
      String clientId, String trainerId, String date) {
    // TODO: implement getExercisesForClient
    throw UnimplementedError();
  }

  @override
  Stream<List<ExerciseEntity>> getExercisesForTrainer(
      String clientId, String trainerId, String date) async* {
    final snapshots = FirebaseFirestore.instance
        .collection(CollectionName.users)
        .doc(trainerId)
        .collection(CollectionName.clients)
        .doc(clientId)
        .collection(date)
        .snapshots();

    await for (final snapshot in snapshots) {
      yield snapshot.docs
          .map(
            (exercise) => ExerciseEntity(
              id: exercise[UserDocumentFields.id] as String,
              description: exercise[UserDocumentFields.description] as String,
              index: exercise[UserDocumentFields.index] as int,
              isRepsBased: exercise[UserDocumentFields.isRepsBased] as bool,
              isTimeBased: exercise[UserDocumentFields.isTimeBased] as bool,
              reps: exercise[UserDocumentFields.reps] as int,
              sets: exercise[UserDocumentFields.sets] as int,
              tags:
                  _getTags(exercise[UserDocumentFields.tags] as List<dynamic>),
              time: exercise[UserDocumentFields.time] as String,
              title: exercise[UserDocumentFields.title] as String,
              videoId: exercise[UserDocumentFields.videoId] as String,
            ),
          )
          .toList();
    }
  }

  @override
  Future<int> getNumberOfExercises(
    String clientId,
    String trainerId,
    String date,
  ) async {
    final snapshot = await FirebaseFirestore.instance
        .collection(CollectionName.users)
        .doc(trainerId)
        .collection(CollectionName.clients)
        .doc(clientId)
        .collection(date)
        .get();

    return snapshot.docs.length;
  }

  List<String> _getTags(List<dynamic> tags) {
    return tags.map<String>((tag) => tag as String).toList();
  }
}
