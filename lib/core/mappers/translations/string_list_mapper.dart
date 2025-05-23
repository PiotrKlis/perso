import 'package:injectable/injectable.dart';
import 'package:perso/app/utils/locale_repository.dart';

@injectable
class StringListTranslationsMapper {
  List<String> map(Map<String, dynamic> value) {
    final key = value.keys.first.split('-').first;
    final input = value.map(
      (key, value) => MapEntry(
        key,
        List<String>.from((value as List).map((element) => element.toString())),
      ),
    );
    switch (LocaleRepository.languageCode) {
      case 'en':
        return input['$key-en']!;
      case 'pl':
        return input['$key-pl']!;
      default:
        throw const FormatException('String translation not found');
    }
  }

  Map<String, dynamic> mapTo(String key, List<String> value) {
    return {
      '$key-${LocaleRepository.languageCode}': value,
    };
  }
}
