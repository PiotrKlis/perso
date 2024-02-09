import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:perso/core/dependency_injection/get_it.dart';
import 'package:perso/core/models/user_session_model.dart';
import 'package:perso/data/utils/firestore_constants.dart';

@injectable
class TrainingRequestService {
  final _userSessionModel = getIt.get<UserSessionModel>();

  Future<void> sendTrainingRequest(String trainerId) async {
    final clientId = _userSessionModel.user?.uid;
    await FirebaseFirestore.instance
        .collection(CollectionName.clients)
        .doc(clientId)
        .update({
      UserDocumentFields.pendingTrainers: FieldValue.arrayUnion([trainerId]),
    });
    await FirebaseFirestore.instance
        .collection(CollectionName.trainers)
        .doc(trainerId)
        .update({
      UserDocumentFields.pendingClients: FieldValue.arrayUnion([clientId]),
    });
  }

  Future<bool> checkIfUserHasAlreadySentRequest(String trainerId) async {
    final clientId = _userSessionModel.user?.uid;
    final document = await FirebaseFirestore.instance
        .collection(CollectionName.clients)
        .doc(clientId)
        .get();

    final pendingRequests =
        (document[UserDocumentFields.pendingTrainers] as List<dynamic>)
            .map((trainer) => trainer as String)
            .toList();
    final activeTrainers =
        (document[UserDocumentFields.activeTrainers] as List<dynamic>)
            .map((trainer) => trainer as String)
            .toList();
    final inactiveTrainers =
        (document[UserDocumentFields.inactiveTrainers] as List<dynamic>)
            .map((trainer) => trainer as String)
            .toList();
    if (pendingRequests.contains(trainerId) ||
        activeTrainers.contains(trainerId) ||
        inactiveTrainers.contains(trainerId)) {
      return true;
    } else {
      return false;
    }
  }
}
