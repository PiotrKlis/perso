import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:perso/data/utils/firestore_constants.dart';

@injectable
class ImageRepository {
  Future<String> getImageUrl(String userId) async {
    return FirebaseStorage.instance
        .ref()
        .child('${CollectionName.images}/$userId/}')
        .getDownloadURL();
  }
}
