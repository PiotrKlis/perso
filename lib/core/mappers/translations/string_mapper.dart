import 'package:injectable/injectable.dart';
import 'package:perso/app/utils/locale_repository.dart';

@injectable
class StringMapper {
  String map(Map<String, String> description) {
    switch (LocaleRepository.languageCode) {
      case 'en':
        return description['en-description']!;
      case 'pl':
        return description['pl-description']!;
      default:
        throw const FormatException('String translation not found');
    }
  }
}
