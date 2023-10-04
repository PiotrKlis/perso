import 'package:Perso/core/dependency_injection/get_it_config.dart';
import 'package:Perso/data/user_info/user_info_provider.dart';
import 'package:Perso/data/utils/firestore_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@injectable
class TrainingRequestService {
  final UserInfoProvider _userInfoProvider = getIt.get<UserInfoProvider>();

  Future<void> sendTrainingRequest(String trainerId) async {
    try {
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
    } catch (error) {
      Future.error(error);
    }
  }
}
