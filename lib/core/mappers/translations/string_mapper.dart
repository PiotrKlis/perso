import 'package:injectable/injectable.dart';
import 'package:perso/app/utils/locale_repository.dart';

@injectable
class StringTranslationsMapper {
  String mapFrom(Map<String, dynamic> value) {
    //TODO: Fix me
    final key = value.keys.first.split('-').first;
    final input = value.map((key, value) => MapEntry(key, value.toString()));
    switch (LocaleRepository.languageCode) {
      case 'en':
        return input['$key-en']!;
      case 'pl':
        return input['$key-pl']!;
      default:
        throw const FormatException('String translation not found');
    }
  }

  Map<String, dynamic> mapTo(String key, String value) {
    return {
      '$key-${LocaleRepository.languageCode}': value,
    };
  }
}
