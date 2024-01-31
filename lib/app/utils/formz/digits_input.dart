import 'package:formz/formz.dart';

class DigitsInput extends FormzInput<String, String> {
  const DigitsInput.pure() : super.pure('');

  const DigitsInput.dirty([super.value = '']) : super.dirty();

  @override
  String? validator(String? value) {
    return RegExp(r'^[0-9]+$').hasMatch(value ?? '')
        ? null
        : 'Please enter only digits';
  }
}
