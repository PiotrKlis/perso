import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:perso/core/models/exercise_entity.dart';
import 'package:perso/data/exercise_provider/exercise_source.dart';
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
  Future<void> addExercise(
    String clientId,
    String trainerId,
    DateTime date,
    ExerciseEntity exerciseEntity,
  ) async {
    await FirebaseFirestore.instance
        .collection(CollectionName.users)
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection(CollectionName.clientExercises)
        .doc(clientId)
        .collection(date.toString())
        .doc(exerciseEntity.id)
        .set({
      UserDocumentFields.id: exerciseEntity.id,
      UserDocumentFields.description: exerciseEntity.description,
      UserDocumentFields.index: exerciseEntity.index,
      UserDocumentFields.isRepsBased: exerciseEntity.isRepsBased,
      UserDocumentFields.isTimeBased: exerciseEntity.isTimeBased,
      UserDocumentFields.reps: exerciseEntity.reps,
      UserDocumentFields.sets: exerciseEntity.sets,
      UserDocumentFields.tags: exerciseEntity.tags,
      UserDocumentFields.time: exerciseEntity.time,
      UserDocumentFields.title: exerciseEntity.title,
      UserDocumentFields.videoId: exerciseEntity.videoId,
    });
  }

  @override
  Future<void> editExercise(
      String clientId, String trainerId, String exerciseId, DateTime date) {
    // TODO: implement editExercise
    throw UnimplementedError();
  }

  @override
  Future<void> removeExercise(
    String clientId,
    String trainerId,
    DateTime date,
    String exerciseId,
  ) {
    // TODO: implement removeExercise
    throw UnimplementedError();
  }

  List<String> _getTags(List<dynamic> tags) {
    return tags.map<String>((tag) => tag as String).toList();
  }
}
