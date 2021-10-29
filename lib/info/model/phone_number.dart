import 'package:formz/formz.dart';

/// Vaidation errors for the [FormzInput] [Phone]
enum PhoneValidationError {
  /// Just a generic invalid error
  invalid
}

enum PhoneCodeValidationError { invalid }

/// Form input for phone field
class Phone extends FormzInput<String, PhoneValidationError> {
  const Phone.pure() : super.pure('');

  const Phone.dirty([String value = '']) : super.dirty(value);

  static final RegExp _phoneRegExp = RegExp(
      // r'\+?1?\s*\(?-*\.*(\d{3})\)?\.*-*\s*(\d{3})\.*-*\s*(\d{4})$',
      r'^[0-9]{9}$');

  @override
  PhoneValidationError? validator(String value) {
    return _phoneRegExp.hasMatch(value) ? null : PhoneValidationError.invalid;
  }
}

class PhoneCode extends FormzInput<String, PhoneCodeValidationError> {
  const PhoneCode.pure() : super.pure('');

  const PhoneCode.dirty([String value = '']) : super.dirty(value);

  static final RegExp _phoneCodeRegExp = RegExp(
    r'\+\d{1,3}|\d{1,4}$',
  );

  @override
  PhoneCodeValidationError? validator(String value) {
    return _phoneCodeRegExp.hasMatch(value)
        ? null
        : PhoneCodeValidationError.invalid;
  }
}
