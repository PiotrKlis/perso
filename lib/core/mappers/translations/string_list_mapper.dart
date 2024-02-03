import 'package:injectable/injectable.dart';
import 'package:perso/app/utils/locale_repository.dart';

@injectable
class StringListMapper {
  List<String> map(Map<String, List<String>> description) {
    switch (LocaleRepository.languageCode) {
      case 'en':
        return description['en-description']!;
      case 'pl':
        return description['pl-description']!;
      default:
        throw const FormatException('List<String> translation not found');
    }
  }
}
