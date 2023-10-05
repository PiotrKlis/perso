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
}
