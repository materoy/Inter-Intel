import 'package:formz/formz.dart';

/// Vaidation errors for the [FormzInput] [Phone]
enum PhoneValidationError {
  /// Just a generic invalid error
  invalid
}

/// Form input for email field
class Phone extends FormzInput<String, PhoneValidationError> {
  const Phone.pure() : super.pure('');

  const Phone.dirty([String value = '']) : super.dirty(value);

  static final RegExp _phoneRegExp = RegExp(
    r'\+?1?\s*\(?-*\.*(\d{3})\)?\.*-*\s*(\d{3})\.*-*\s*(\d{4})$',
  );

  @override
  PhoneValidationError? validator(String value) {
    return _phoneRegExp.hasMatch(value) ? null : PhoneValidationError.invalid;
  }
}
