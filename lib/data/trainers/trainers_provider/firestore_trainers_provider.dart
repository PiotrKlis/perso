import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:perso/core/dependency_injection/get_it.dart';
import 'package:perso/core/extensions/string_extensions.dart';
import 'package:perso/core/mappers/trainer_entity_mapper.dart';
import 'package:perso/core/models/trainer_entity.dart';
import 'package:perso/core/models/trainer_identity.dart';
import 'package:perso/core/models/user_type.dart';
import 'package:perso/data/trainers/trainers_provider/trainers_source.dart';
import 'package:perso/data/utils/firestore_constants.dart';

@injectable
class FirestoreTrainersProvider implements TrainersSource {
  final _trainerEntityMapper = getIt.get<TrainerEntityMapper>();

  @override
  Future<List<TrainerEntity>> getAllTrainersData() async {
    final QuerySnapshot trainersSnapshot = await FirebaseFirestore.instance
        .collection(CollectionName.users)
        .where(UserDocumentFields.userType, isEqualTo: UserType.trainer.name)
        .get();

    return trainersSnapshot.docs
        .map(_trainerEntityMapper.mapQuerySnapshot)
        .toList();
  }

  @override
  Stream<TrainerEntity> getTrainers(String id) async* {
    final snapshots = FirebaseFirestore.instance
        .collection(CollectionName.users)
        .doc(id)
        .snapshots();

    await for (final snapshot in snapshots) {
      yield _trainerEntityMapper.mapStream(snapshot.data()!);
    }
  }

  //TODO: Add categories fetched from the remote
  @override
  Future<List<String>> getSpecialities(String id) async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection(CollectionName.users)
        .where(UserDocumentFields.id, isEqualTo: id)
        .get();

    final categories = snapshot.docs.first[UserDocumentFields.categories]
        .toString()
        .removeBrackets()
        .split(', ');
    return categories;
  }

  @override
  Future<List<TrainerIdentity>> getTrainersForClient(
    String clientId,
  ) async {
    final trainersSnapshots = await FirebaseFirestore.instance
        .collection(CollectionName.users)
        .doc(clientId)
        .get();

    final trainersIds =
        (trainersSnapshots[UserDocumentFields.activeTrainers] as List<dynamic>)
            .map((e) => e.toString())
            .toList();

    return Future.wait(
      trainersIds.map(
        (trainerId) async {
          final trainerSnapshot = await FirebaseFirestore.instance
              .collection(CollectionName.users)
              .doc(trainerId)
              .get();

          return TrainerIdentity(
            id: trainerSnapshot.id,
            name: trainerSnapshot[UserDocumentFields.name] as String,
            surname: trainerSnapshot[UserDocumentFields.surname] as String,
            nickname: trainerSnapshot[UserDocumentFields.nickname] as String,
          );
        },
      ),
    );
  }

  @override
  Future<TrainerEntity> getTrainer(String id) async {
    final trainersSnapshots = await FirebaseFirestore.instance
        .collection(CollectionName.users)
        .doc(id)
        .get();

    return _trainerEntityMapper.mapDocumentSnapshot(trainersSnapshots);
  }
}
