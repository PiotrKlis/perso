import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:perso/app/utils/extension/string_extensions.dart';
import 'package:perso/core/dependency_injection/get_it.dart';
import 'package:perso/core/mappers/translations/string_list_mapper.dart';
import 'package:perso/core/mappers/translations/string_mapper.dart';
import 'package:perso/core/models/exercise_entity.dart';
import 'package:perso/core/models/exercise_in_training_entity.dart';
import 'package:perso/core/models/exercise_type.dart';
import 'package:perso/data/exercises/exercises_source/exercise_source.dart';
import 'package:perso/data/utils/firestore_constants.dart';

@injectable
class FirestoreExerciseProvider extends ExerciseSource {
  final _stringTranslationsMapper = getIt.get<StringMapper>();
  final _stringListTranslationsMapper = getIt.get<StringListMapper>();

  @override
  Future<List<ExerciseEntity>> getAllExercises() async {
    final exerciseSnapshots = await FirebaseFirestore.instance
        .collection(CollectionName.exercises)
        .get();

    final exercises = Future.wait(
      exerciseSnapshots.docs.map(
        (exercise) async {
          return ExerciseEntity(
            id: exercise[UserDocumentFields.id] as String,
            description: _stringTranslationsMapper.map(
              exercise[UserDocumentFields.description] as Map<String, String>,
            ),
            index: exercise[UserDocumentFields.index] as int,
            exerciseType: (exercise[UserDocumentFields.exerciseType] as String)
                .toExerciseType()!,
            reps: exercise[UserDocumentFields.reps] as int,
            sets: exercise[UserDocumentFields.sets] as int,
            tags: _stringListTranslationsMapper.map(
              exercise[UserDocumentFields.tags] as Map<String, List<String>>,
            ),
            time: exercise[UserDocumentFields.time] as String,
            title: _stringTranslationsMapper
                .map(exercise[UserDocumentFields.title] as Map<String, String>),
            videoId: exercise[UserDocumentFields.videoId] as String,
          );
        },
      ).toList(),
    );
    return exercises;
  }

  @override
  Future<List<ExerciseEntity>> getExercisesForClient(
    String clientId,
    String trainerId,
    String date,
  ) {
    // TODO: implement getExercisesForClient
    throw UnimplementedError();
  }

  @override
  Future<List<ExerciseInTrainingEntity>> getExercisesForTrainer(
    String clientId,
    String trainerId,
    String date,
  ) async {
    final snapshots = await FirebaseFirestore.instance
        .collection(CollectionName.users)
        .doc(trainerId)
        .collection(CollectionName.clients)
        .doc(clientId)
        .collection(date)
        .get();

    return Future.wait(
      snapshots.docs
          .map(
            (exercise) async => ExerciseInTrainingEntity(
              id: exercise.id,
              exerciseEntity: ExerciseEntity(
                id: exercise[UserDocumentFields.id] as String,
                description: exercise[UserDocumentFields.description] as String,
                index: exercise[UserDocumentFields.index] as int,
                exerciseType:
                    (exercise[UserDocumentFields.exerciseType] as String)
                        .toExerciseType()!,
                reps: exercise[UserDocumentFields.reps] as int,
                sets: exercise[UserDocumentFields.sets] as int,
                tags: exercise[UserDocumentFields.tags] as List<String>,
                time: exercise[UserDocumentFields.time] as String,
                title: exercise[UserDocumentFields.title] as String,
                videoId: exercise[UserDocumentFields.videoId] as String,
              ),
            ),
          )
          .toList(),
    );
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

  @override
  Future<Map<DateTime, bool>> getMarkersForDates(
    String clientId,
    String trainerId,
    DateTime startDate,
    DateTime endDate,
  ) async {
    final docRef = FirebaseFirestore.instance
        .collection(CollectionName.users)
        .doc(trainerId)
        .collection(CollectionName.clients)
        .doc(clientId);

    final collectionList = <Future<QuerySnapshot>>[];
    final collectionIds = getDateIds(startDate, endDate);
    for (final id in collectionIds) {
      final colRef = docRef.collection(id);
      collectionList.add(colRef.get());
    }
    final collection = await Future.wait(collectionList);

    return collection.asMap().map<DateTime, bool>((index, collection) {
      return MapEntry(
        collectionIds[index].yearMonthDayFormat,
        collection.docs.isNotEmpty,
      );
    });
  }

  List<String> getDateIds(DateTime startDate, DateTime endDate) {
    final dateIds = <String>[];
    var currentDate = startDate;

    while (currentDate.isBefore(endDate) ||
        currentDate.isAtSameMomentAs(endDate)) {
      dateIds.add(DateFormat('yyyy-MM-dd').format(currentDate));
      currentDate = currentDate.add(const Duration(days: 1));
    }
    return dateIds;
  }
}
