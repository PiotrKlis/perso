class TextFieldValidator {
  static String? validateEmail(String value) {
    final RegExp emailRegex = RegExp(
      r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
    );

    if (value.isEmpty) {
      return '*Required Field';
    } else if (!emailRegex.hasMatch(value)) {
      return "Please enter a valid email address";
    } else {
      return null;
    }
  }

  static String? validatePassword(String value) {
    const minLength = 8;
    final hasUppercase = RegExp(r'[A-Z]').hasMatch(value);
    final hasLowercase = RegExp(r'[a-z]').hasMatch(value);
    final hasDigit = RegExp(r'\d').hasMatch(value);

    if (value.isEmpty) {
      return '*Required Field';
    } else if (value.length >= minLength &&
        hasUppercase &&
        hasLowercase &&
        hasDigit) {
      return null;
    } else {
      return "Password needs to be at least 8 characters, with an uppercase and a number";
    }
  }

  static String? validateName(String value) {
    if (value.isEmpty) {
      return '*Required Field';
    } else {
      return null;
    }
  }

  static String? validateNickname(String value) {
    if (value.isEmpty) {
      return '*Required Field';
    } else {
      return null;
    }
  }
}
