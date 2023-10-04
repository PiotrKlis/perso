import 'package:Perso/core/dependency_injection/get_it_config.dart';
import 'package:Perso/data/user_info/user_info_provider.dart';
import 'package:Perso/data/utils/firestore_constants.dart';
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
      UserDocumentFields.pendingRequests: FieldValue.arrayUnion([trainerId])
    });
    await FirebaseFirestore.instance
        .collection(CollectionName.users)
        .doc(trainerId)
        .update({
      UserDocumentFields.pendingRequests: FieldValue.arrayUnion([clientId])
    });
  }

  Future<bool> checkIfUserHasAlreadySentRequest(String trainerId) async {
    final clientId = _userInfoProvider.user?.uid;
    final document = await FirebaseFirestore.instance
        .collection(CollectionName.users)
        .doc(clientId)
        .get();

    final pendingRequests =
        document.get(UserDocumentFields.pendingRequests);
    final activeTrainers =
        document.get(UserDocumentFields.activeTrainers);
    final inactiveTrainers =
        document.get(UserDocumentFields.inactiveTrainers);

    if (pendingRequests.contains(trainerId) ||
        activeTrainers.contains(trainerId) ||
        inactiveTrainers.contains(trainerId)) {
      return true;
    } else {
      return false;
    }
  }
}
