import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:inter_intel_interview/info/info.dart';
import 'package:inter_intel_interview/info/model/email.dart';
import 'package:inter_intel_interview/info/model/phone_number.dart';
import 'package:meta/meta.dart';

part 'info_state.dart';

class InfoCubit extends Cubit<InfoState> {
  InfoCubit() : super(const InfoState());

  void firstNameChanged(String value) {
    emit(state.copyWith(
        firstName: value,
        status: Formz.validate([state.email, state.phoneNumber])));
  }

  void lastNameChanged(String value) {
    emit(state.copyWith(
        lastName: value,
        status: Formz.validate([state.email, state.phoneNumber])));
  }

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(state.copyWith(
        email: email, status: Formz.validate([email, state.phoneNumber])));
  }

  void phoneNumberChanged(String value) {
    final phoneNumber = Phone.dirty(value);
    emit(state.copyWith(
        phoneNumber: phoneNumber,
        status: Formz.validate([state.email, phoneNumber])));
  }

  Future<void> submitForm() async {
    if (!state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
      return;
    }

    emit(state.copyWith(status: FormzStatus.submissionInProgress));

    // final user = User(
    //     firstName: state.firstName,
    //     lastName: state.lastName,
    //     email: state.email.value,
    //     phoneNumber: state.phoneNumber.value);

    /// A simulated network request delay
    await Future<void>.delayed(const Duration(seconds: 2));

    emit(state.copyWith(status: FormzStatus.submissionSuccess));
  }
}
