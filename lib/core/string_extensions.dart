extension StringExtension on String {
  String capitalizeFirstLetter() {
    if (isEmpty) {
      return this;
    }
    return this[0].toUpperCase() + substring(1).toLowerCase();
  }

  String removeBrackets() {
    if (isEmpty) {
      return this;
    }
    return replaceAll('[', '').replaceAll(']', '');
  }

  String removeLeadingZeroes() {
    return int.parse(this).toString();
  }

  String limitToTwoDigits() {
    return length > 2 ? substring(0, 2) : this;
  }
}
