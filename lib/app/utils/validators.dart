import 'package:perso/core/dependency_injection/get_it.dart';
import 'package:perso/core/providers/string_provider.dart';

class TextFieldValidator {
  static final stringProvider = getIt.get<StringProvider>();

  static String? validateEmail(String value) {
    final emailRegex = RegExp(
      r'^\S+@\S+\.[a-zA-Z]{2,7}$',
    );

    if (value.isEmpty) {
      return stringProvider.strings.required_field;
    } else if (!emailRegex.hasMatch(value)) {
      return stringProvider.strings.enter_valid_email;
    } else {
      return null;
    }
  }

  static String? validatePassword(String value) {
    const minLength = 8;
    final hasUppercase = RegExp(r'\S*[A-Z]\S*').hasMatch(value);
    final hasLowercase = RegExp(r'\S*[a-z]\S*').hasMatch(value);
    final hasDigit = RegExp(r'\S*\d\S*').hasMatch(value);

    if (value.isEmpty) {
      return stringProvider.strings.required_field;
    } else if (value.length >= minLength &&
        hasUppercase &&
        hasLowercase &&
        hasDigit) {
      return null;
    } else {
      return stringProvider.strings.password_not_valid;
    }
  }

  static String? validateSameText(String input, String valueToCompare) {
    if (input.isEmpty) {
      return stringProvider.strings.required_field;
    } else if (input != valueToCompare) {
      return stringProvider.strings.passwords_not_match;
    } else {
      return null;
    }
  }

  static String? validateIsEmpty(String value) {
    value.trim();
    if (value.isEmpty) {
      return stringProvider.strings.required_field;
    } else {
      return null;
    }
  }

  static String? validateDigits(String value) {
    if (value.isEmpty) {
      return null;
    }

    final digitsRegex = RegExp(r'^[0-9]+$');
    if (!digitsRegex.hasMatch(value)) {
      return stringProvider.strings.digits_only;
    }
    return null;
  }

  static String? validateNonZeroDigits(String value) {
    if (value == '0') {
      return stringProvider.strings.value_cannot_be_0;
    }

    final digitsRegex = RegExp(r'^[0-9]+$');
    if (!digitsRegex.hasMatch(value)) {
      return stringProvider.strings.digits_only;
    }
    return null;
  }
}
