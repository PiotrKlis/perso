import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:perso/app/screens/plan_overview/exercise_options_data.dart';
import 'package:perso/app/utils/extension/date_time_extensions.dart';
import 'package:perso/core/dependency_injection/get_it.dart';
import 'package:perso/core/mappers/translations/string_list_mapper.dart';
import 'package:perso/core/mappers/translations/string_mapper.dart';
import 'package:perso/core/models/exercise_entity.dart';
import 'package:perso/core/models/exercise_in_training_entity.dart';
import 'package:perso/data/exercises/exercises_service/exercise_service.dart';
import 'package:perso/data/utils/firestore_constants.dart';

@injectable
class FirestoreExerciseService extends ExerciseService {
  final _stringTranslationsMapper = getIt.get<StringTranslationsMapper>();
  final _stringListTranslationsMapper =
      getIt.get<StringListTranslationsMapper>();

  @override
  Future<void> add({
    required String clientId,
    required String trainerId,
    required String date,
    required ExerciseEntity exerciseEntity,
  }) async {
    await FirebaseFirestore.instance
        .collection(CollectionName.trainers)
        .doc(trainerId)
        .collection(CollectionName.clients)
        .doc(clientId)
        .collection(date)
        .doc()
        .set({
      UserDocumentFields.id: exerciseEntity.id,
      UserDocumentFields.description: _stringTranslationsMapper.mapTo(
        UserDocumentFields.description,
        exerciseEntity.description,
      ),
      UserDocumentFields.index: exerciseEntity.index,
      UserDocumentFields.reps: exerciseEntity.reps,
      UserDocumentFields.sets: exerciseEntity.sets,
      UserDocumentFields.tags: _stringListTranslationsMapper.mapTo(
        UserDocumentFields.tags,
        exerciseEntity.tags,
      ),
      UserDocumentFields.time: exerciseEntity.time,
      UserDocumentFields.title: _stringTranslationsMapper.mapTo(
        UserDocumentFields.title,
        exerciseEntity.title,
      ),
      UserDocumentFields.videoId: exerciseEntity.videoId,
      UserDocumentFields.exerciseType: exerciseEntity.exerciseType.name,
      UserDocumentFields.timeBreak: exerciseEntity.timeBreak,
    });
  }

  @override
  Future<void> editExerciseOptions({
    required String clientId,
    required String trainerId,
    required String exerciseId,
    required String date,
    required ExerciseOptionsData exerciseOptions,
  }) async {
    await FirebaseFirestore.instance
        .collection(CollectionName.trainers)
        .doc(trainerId)
        .collection(CollectionName.clients)
        .doc(clientId)
        .collection(date)
        .doc(exerciseId)
        .update({
      UserDocumentFields.exerciseType: exerciseOptions.exerciseType.name,
      UserDocumentFields.sets: exerciseOptions.sets,
      UserDocumentFields.reps: exerciseOptions.reps,
      UserDocumentFields.time: exerciseOptions.time,
      UserDocumentFields.timeBreak: exerciseOptions.timeBreak,
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
        .collection(CollectionName.trainers)
        .doc(trainerId)
        .collection(CollectionName.clients)
        .doc(clientId)
        .collection(date)
        .doc(exerciseInTrainingEntity.id)
        .delete();

    final batch = FirebaseFirestore.instance.batch();
    final collection = FirebaseFirestore.instance
        .collection(CollectionName.trainers)
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
        .collection(CollectionName.trainers)
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
        .collection(CollectionName.trainers)
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
        .collection(CollectionName.trainers)
        .doc(trainerId)
        .collection(CollectionName.clients)
        .doc(clientId);

    final sentDate = DateTime.now().yearMonthDayHourMinuteSecondsFormat;
    await sourceDocument.set({date: sentDate}, SetOptions(merge: true));

    final sourceCollection = sourceDocument.collection(date);

    final targetCollection = FirebaseFirestore.instance
        .collection(CollectionName.clients)
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
}
