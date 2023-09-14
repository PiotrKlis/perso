import 'package:Perso/core/user_type.dart';
import 'package:Perso/data/shared_prefs/perso_shared_prefs.dart';
import 'package:Perso/data/utils/firestore_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

@injectable
class UserInfoProvider {
  final PersoSharedPrefs _sharedPrefs = GetIt.I.get<PersoSharedPrefs>();

  bool isUserLoggedIn() {
    if (FirebaseAuth.instance.currentUser != null &&
        FirebaseAuth.instance.currentUser!.emailVerified &&
        _sharedPrefs.getBool(PersoSharedPrefs.isProfileCreatedKey)) {
      return true;
    } else {
      return false;
    }
  }

  Future<UserType> getUserType() async {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? "";
    final DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection(CollectionName.users)
        .doc(userId)
        .get();
    String userType = snapshot.get(UserDocumentFields.userType);
    return userType.toUserType();
  }
}
