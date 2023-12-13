import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:perso/core/models/exercise_entity.dart';
import 'package:perso/data/exercises/exercises_service/exercise_service.dart';
import 'package:perso/data/utils/firestore_constants.dart';

@injectable
class FirestoreExerciseService extends ExerciseService {
  @override
  Future<void> addExercise(
    String clientId,
    String trainerId,
    String date,
    ExerciseEntity exerciseEntity,
  ) async {
    await FirebaseFirestore.instance
        .collection(CollectionName.users)
        .doc(trainerId)
        .collection(CollectionName.exercises)
        .doc(clientId)
        .collection(date)
        .doc()
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
    String clientId,
    String trainerId,
    String exerciseId,
    String date,
  ) {
    // TODO: implement editExercise
    throw UnimplementedError();
  }

  @override
  Future<void> removeExercise(
    String clientId,
    String trainerId,
    String date,
    String exerciseId,
  ) {
    // TODO: implement removeExercise
    throw UnimplementedError();
  }
}
