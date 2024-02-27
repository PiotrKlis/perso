import 'package:uuid/uuid.dart';
class UuidGenerator {
  static String generateShortUuid() {
    return const Uuid().v4().replaceAll('-', '').substring(0, 20);
  }
}