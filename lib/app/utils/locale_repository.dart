import 'dart:io';

class LocaleRepository {
  static late String languageCode;

  static void init() {
    final localeName = Platform.localeName.split('_').first;
    switch (localeName) {
      case 'en':
        languageCode = SupportedLocales.english.value;
        break;
      case 'pl':
        languageCode = SupportedLocales.polish.value;
        break;
      default:
        languageCode = SupportedLocales.english.value;
    }
  }
}

enum SupportedLocales {
  english('en'),
  polish('pl');

  const SupportedLocales(this.value);

  final String value;
}
