import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:perso/core/dependency_injection/get_it.dart';
import 'package:perso/core/extensions/string_extensions.dart';
import 'package:perso/core/mappers/exercise_entity_mapper.dart';
import 'package:perso/core/models/exercise_entity.dart';
import 'package:perso/core/models/exercise_in_training_entity.dart';
import 'package:perso/data/exercises/exercises_source/exercise_source.dart';
import 'package:perso/data/utils/firestore_constants.dart';

@injectable
class FirestoreExerciseProvider extends ExerciseSource {
  final _exerciseEntityMapper = getIt.get<ExerciseEntityMapper>();

  @override
  Future<List<ExerciseEntity>> getAllExercises() async {
    final exerciseSnapshots = await FirebaseFirestore.instance
        .collection(CollectionName.exercises)
        .get();

    return Future.wait(
      exerciseSnapshots.docs
          .map(
            (exercise) async => _exerciseEntityMapper.map(exercise),
          )
          .toList(),
    );
  }

  @override
  Future<List<ExerciseInTrainingEntity>> getExercisesForTrainer({
    required String clientId,
    required String trainerId,
    required String date,
  }) async {
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
              exerciseEntity: _exerciseEntityMapper.map(exercise),
            ),
          )
          .toList(),
    );
  }

  @override
  Future<List<ExerciseInTrainingEntity>> getExercisesForClient({
    required String clientId,
    required String trainerId,
    required String date,
  }) async {
    final docSnapshot = await FirebaseFirestore.instance
        .collection(CollectionName.users)
        .doc(trainerId)
        .collection(CollectionName.clients)
        .doc(clientId)
        .get();

    final data = docSnapshot.data();

    if (data != null && data.containsKey(date)) {
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
                exerciseEntity: _exerciseEntityMapper.map(exercise),
              ),
            )
            .toList(),
      );
    } else {
      return [];
    }
  }

  @override
  Future<int> getNumberOfExercises({
    required String clientId,
    required String trainerId,
    required String date,
  }) async {
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
  Future<List<DateTime>> getMarkersForDates(
    String clientId,
    String trainerId,
    DateTime startDate,
    DateTime endDate,
  ) async {
    final document = await FirebaseFirestore.instance
        .collection(CollectionName.users)
        .doc(trainerId)
        .collection(CollectionName.clients)
        .doc(clientId)
        .get();

    final markers = <DateTime>[];
    final collectionIds = _getDateIds(startDate, endDate);
    for (final id in collectionIds) {
      final data = document.data();
      if (data != null && data.containsKey(id)) {
        markers.add(id.yearMonthDayFormat);
      }
    }
    return markers;
  }

  List<String> _getDateIds(DateTime startDate, DateTime endDate) {
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
