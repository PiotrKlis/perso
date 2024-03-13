import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:perso/app/utils/extension/date_time_extensions.dart';
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
    required ExerciseInTrainingEntity exerciseInTrainingEntity,
  }) async {
    final exerciseEntity = exerciseInTrainingEntity.exerciseEntity;
    final exerciseToBeCopied = await FirebaseFirestore.instance
        .collection(CollectionName.exercises)
        .doc(exerciseEntity.id)
        .get();

    final path = FirebaseFirestore.instance
        .collection(CollectionName.users)
        .doc(trainerId)
        .collection(CollectionName.clients)
        .doc(clientId)
        .collection(date)
        .doc(exerciseInTrainingEntity.id);
    await path.set(exerciseToBeCopied.data()!);

    await path.update({
      UserDocumentFields.index: exerciseEntity.index,
      UserDocumentFields.reps: exerciseEntity.exerciseOptionsData.reps,
      UserDocumentFields.sets: exerciseEntity.exerciseOptionsData.sets,
      UserDocumentFields.time: exerciseEntity.exerciseOptionsData.time,
      UserDocumentFields.exerciseType:
          exerciseEntity.exerciseOptionsData.exerciseType.name,
      UserDocumentFields.timeBreak:
          exerciseEntity.exerciseOptionsData.timeBreak,
      UserDocumentFields.supersetName:
          exerciseEntity.exerciseOptionsData.supersetName,
      UserDocumentFields.repsInReserve:
          exerciseEntity.exerciseOptionsData.repsInReserve,
      UserDocumentFields.rateOfPerceivedExertion:
          exerciseEntity.exerciseOptionsData.rateOfPerceivedExertion,
      UserDocumentFields.maxPercentage:
          exerciseEntity.exerciseOptionsData.maxPercentage,
      UserDocumentFields.trainerNote:
          exerciseEntity.exerciseOptionsData.trainerNote,
      UserDocumentFields.weight: exerciseEntity.exerciseOptionsData.weight,
    });
  }

  @override
  Future<void> remove({
    required String clientId,
    required String trainerId,
    required String date,
    required String exerciseInTrainingId,
  }) async {
    await FirebaseFirestore.instance
        .collection(CollectionName.users)
        .doc(trainerId)
        .collection(CollectionName.clients)
        .doc(clientId)
        .collection(date)
        .doc(exerciseInTrainingId)
        .delete();
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
  Future<String> getSentDate(
      {required String clientId,
      required String trainerId,
      required String date}) async {
    final client = await FirebaseFirestore.instance
        .collection(CollectionName.users)
        .doc(trainerId)
        .collection(CollectionName.clients)
        .doc(clientId)
        .get();

    final data = client.data();
    if (data != null && data.containsKey(date)) {
      final sentDate = data[date] as String;
      return sentDate;
    } else {
      return '';
    }
  }

  @override
  Future<String> sendToClient({
    required String clientId,
    required String trainerId,
    required String date,
  }) async {
    final sourceDocument = FirebaseFirestore.instance
        .collection(CollectionName.users)
        .doc(trainerId)
        .collection(CollectionName.clients)
        .doc(clientId);

    final sentDate = DateTime.now().yearMonthDayHourMinuteSecondsFormat;
    await sourceDocument.set({date: sentDate}, SetOptions(merge: true));

    final sourceCollection = sourceDocument.collection(date);

    final targetCollection = FirebaseFirestore.instance
        .collection(CollectionName.users)
        .doc(clientId)
        .collection(CollectionName.trainers)
        .doc(trainerId)
        .collection(date);

    final querySnapshot = await sourceCollection.get();
    for (final document in querySnapshot.docs) {
      await targetCollection.doc(document.id).set(document.data());
    }
    return sentDate;
  }

  @override
  Future<void> sendSupersetData({
    required String trainerId,
    required String clientId,
    required String date,
    required Map<String, String> supersetData,
  }) async {
    final batch = FirebaseFirestore.instance.batch();
    final collection = FirebaseFirestore.instance
        .collection(CollectionName.users)
        .doc(trainerId)
        .collection(CollectionName.clients)
        .doc(clientId)
        .collection(date);

    for (final superset in supersetData.entries) {
      final docRef = collection.doc(superset.key);
      batch.update(docRef, {
        UserDocumentFields.supersetName: superset.value,
      });
    }
    await batch.commit();
  }
}
