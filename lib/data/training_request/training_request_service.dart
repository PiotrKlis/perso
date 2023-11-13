import 'package:perso/core/dependency_injection/get_it.dart';
import 'package:perso/data/user_info/user_info_provider.dart';
import 'package:perso/data/utils/firestore_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@injectable
class TrainingRequestService {
  final UserInfoProvider _userInfoProvider = getIt.get<UserInfoProvider>();

  Future<void> sendTrainingRequest(String trainerId) async {
    final clientId = _userInfoProvider.user?.uid;
    await FirebaseFirestore.instance
        .collection(CollectionName.users)
        .doc(clientId)
        .update({
      UserDocumentFields.pendingTrainers: FieldValue.arrayUnion([trainerId]),
    });
    await FirebaseFirestore.instance
        .collection(CollectionName.users)
        .doc(trainerId)
        .update({
      UserDocumentFields.pendingClients: FieldValue.arrayUnion([clientId]),
    });
  }

  Future<bool> checkIfUserHasAlreadySentRequest(String trainerId) async {
    final clientId = _userInfoProvider.user?.uid;
    final document = await FirebaseFirestore.instance
        .collection(CollectionName.users)
        .doc(clientId)
        .get();

    final pendingRequests =
        document[UserDocumentFields.pendingClients] as List<String>;
    final activeTrainers =
        document[UserDocumentFields.activeTrainers] as List<String>;
    final inactiveTrainers =
        document[UserDocumentFields.inactiveTrainers] as List<String>;

    if (pendingRequests.contains(trainerId) ||
        activeTrainers.contains(trainerId) ||
        inactiveTrainers.contains(trainerId)) {
      return true;
    } else {
      return false;
    }
  }
}
