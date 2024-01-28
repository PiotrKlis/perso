import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:perso/core/models/exercise_entity.dart';
import 'package:perso/core/models/exercise_in_training_entity.dart';
import 'package:perso/data/exercises/exercises_service/exercise_service.dart';
import 'package:perso/data/utils/firestore_constants.dart';

@injectable
class FirestoreExerciseService extends ExerciseService {
  @override
  Future<void> add({
    required String clientId,
    required String trainerId,
    required String date,
    required ExerciseEntity exerciseEntity,
  }) async {
    final tagsDocRef = exerciseEntity.tags
        .map(
          (tag) => FirebaseFirestore.instance
              .collection(CollectionName.tags)
              .doc(tag.id),
        )
        .toList();

    await FirebaseFirestore.instance
        .collection(CollectionName.users)
        .doc(trainerId)
        .collection(CollectionName.clients)
        .doc(clientId)
        .collection(date)
        .doc()
        .set({
      UserDocumentFields.id: exerciseEntity.id,
      UserDocumentFields.description: exerciseEntity.description,
      UserDocumentFields.index: exerciseEntity.index,
      UserDocumentFields.reps: exerciseEntity.reps,
      UserDocumentFields.sets: exerciseEntity.sets,
      UserDocumentFields.tags: tagsDocRef,
      UserDocumentFields.time: exerciseEntity.time,
      UserDocumentFields.title: exerciseEntity.title,
      UserDocumentFields.videoId: exerciseEntity.videoId,
      UserDocumentFields.exerciseType: exerciseEntity.exerciseType.name,
    });
  }

  @override
  Future<void> editExerciseType({
    required String clientId,
    required String trainerId,
    required String exerciseId,
    required String date,
    required String exerciseType,
  }) async {
    await FirebaseFirestore.instance
        .collection(CollectionName.users)
        .doc(trainerId)
        .collection(CollectionName.clients)
        .doc(clientId)
        .collection(date)
        .doc(exerciseId)
        .update({
      UserDocumentFields.exerciseType: exerciseType,
    });
  }

  @override
  Future<void> remove({
    required String clientId,
    required String trainerId,
    required String date,
    required ExerciseInTrainingEntity exerciseInTrainingEntity,
    required List<ExerciseInTrainingEntity> exerciseInTrainingEntityList,
  }) async {
    await FirebaseFirestore.instance
        .collection(CollectionName.users)
        .doc(trainerId)
        .collection(CollectionName.clients)
        .doc(clientId)
        .collection(date)
        .doc(exerciseInTrainingEntity.id)
        .delete();

    final batch = FirebaseFirestore.instance.batch();
    final collection = FirebaseFirestore.instance
        .collection(CollectionName.users)
        .doc(trainerId)
        .collection(CollectionName.clients)
        .doc(clientId)
        .collection(date);

    for (final exercise in exerciseInTrainingEntityList) {
      final docRef = collection.doc(exercise.id);
      batch.update(docRef, {
        UserDocumentFields.index: exercise.exerciseEntity.index,
      });
    }
    await batch.commit();
  }

  @override
  Future<void> reorder({
    required String clientId,
    required String trainerId,
    required String date,
    required List<ExerciseInTrainingEntity> exercises,
  }) async {
    final batch = FirebaseFirestore.instance.batch();
    final collection = FirebaseFirestore.instance
        .collection(CollectionName.users)
        .doc(trainerId)
        .collection(CollectionName.clients)
        .doc(clientId)
        .collection(date);

    for (final exercise in exercises) {
      final docRef = collection.doc(exercise.id);
      batch.update(docRef, {
        UserDocumentFields.index: exercise.exerciseEntity.index,
      });
    }
    await batch.commit();
  }

  @override
  Future<void> editReps({
    required String clientId,
    required String trainerId,
    required String date,
    required String exerciseId,
    required int reps,
    required int sets,
  }) async {
    await FirebaseFirestore.instance
        .collection(CollectionName.users)
        .doc(trainerId)
        .collection(CollectionName.clients)
        .doc(clientId)
        .collection(date)
        .doc(exerciseId)
        .update({
      UserDocumentFields.reps: reps,
      UserDocumentFields.sets: sets,
    });
  }

  @override
  Future<void> editTime({
    required String clientId,
    required String trainerId,
    required String date,
    required String exerciseId,
    required String time,
  }) async {
    await FirebaseFirestore.instance
        .collection(CollectionName.users)
        .doc(trainerId)
        .collection(CollectionName.clients)
        .doc(clientId)
        .collection(date)
        .doc(exerciseId)
        .update({
      UserDocumentFields.time: time,
    });
  }
}
