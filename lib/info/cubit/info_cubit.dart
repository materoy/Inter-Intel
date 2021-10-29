import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:inter_intel_interview/info/model/email.dart';
import 'package:inter_intel_interview/info/model/phone_number.dart';
import 'package:meta/meta.dart';

part 'info_state.dart';

class InfoCubit extends Cubit<InfoState> {
  InfoCubit() : super(const InfoState());

  void firstNameChanged(String value) {
    emit(state.copyWith(
        firstName: value,
        status:
            Formz.validate([state.email, state.phoneNumber, state.phoneCode])));
  }

  void lastNameChanged(String value) {
    emit(state.copyWith(
        lastName: value,
        status:
            Formz.validate([state.email, state.phoneNumber, state.phoneCode])));
  }

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(state.copyWith(
        email: email,
        status: Formz.validate([email, state.phoneNumber, state.phoneCode])));
  }

  void phoneCodeChanged(String value) {
    final phoneCode = PhoneCode.dirty(value);
    emit(state.copyWith(
        phoneCode: phoneCode,
        status: Formz.validate([state.email, phoneCode, state.phoneNumber])));
  }

  void phoneNumberChanged(String value) {
    final phoneNumber = Phone.dirty(value);
    emit(state.copyWith(
        phoneNumber: phoneNumber,
        status: Formz.validate([state.email, phoneNumber, state.phoneCode])));
  }

  Future<void> submitForm() async {
    if (!state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
      return;
    }

    emit(state.copyWith(status: FormzStatus.submissionSuccess));
  }
}
