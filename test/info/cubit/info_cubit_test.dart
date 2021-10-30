import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:inter_intel_interview/info/cubit/info_cubit.dart';
import 'package:inter_intel_interview/info/model/email.dart';
import 'package:inter_intel_interview/info/model/phone_number.dart';

void main() {
  testWidgets('info cubit ...', (tester) async {});

  group('Info Cubit', () {
    test('all fields are empty at initial state', () {
      const state = InfoState();
      expect(InfoCubit().state, state);
      expect(state.email, const Email.pure());
      expect(state.firstName, '');
      expect(state.lastName, '');
      expect(state.phoneCode, const PhoneCode.pure());
      expect(state.phoneNumber, const Phone.pure());
      expect(state.status, FormzStatus.pure);
    });

    blocTest<InfoCubit, InfoState>(
      'validates correct email',
      build: () => InfoCubit(),
      act: (cubit) => cubit.emailChanged('email@email.com'),
      expect: () => [
        const InfoState(
            email: Email.dirty('email@email.com'), status: FormzStatus.invalid)
      ],
    );

    blocTest<InfoCubit, InfoState>(
      'validates correct phone code',
      build: () => InfoCubit(),
      act: (cubit) => cubit.phoneCodeChanged('+254'),
      expect: () => [
        const InfoState(
            phoneCode: PhoneCode.dirty('+254'), status: FormzStatus.invalid)
      ],
    );

    blocTest<InfoCubit, InfoState>(
      'validates correct phone number',
      build: () => InfoCubit(),
      act: (cubit) => cubit.phoneNumberChanged('123456789'),
      expect: () => [
        const InfoState(
            phoneNumber: Phone.dirty('123456789'), status: FormzStatus.invalid)
      ],
    );

    const email = Email.dirty('email@email.com');
    const phoneCode = PhoneCode.dirty('+254');
    const phone = Phone.dirty('123456789');
    const firstName = 'FirstName';
    const lastName = 'LastName';

    blocTest<InfoCubit, InfoState>(
      'validates all fields',
      build: () => InfoCubit(),
      act: (cubit) {
        cubit.emit(cubit.state.copyWith(
            email: email,
            firstName: firstName,
            lastName: lastName,
            phoneCode: phoneCode,
            phoneNumber: phone,
            status: Formz.validate([
              email,
            ])));
      },
      expect: () => [
        const InfoState(
          email: email,
          firstName: firstName,
          lastName: lastName,
          phoneCode: phoneCode,
          phoneNumber: phone,
          status: FormzStatus.valid,
        ),
      ],
    );

    blocTest<InfoCubit, InfoState>(
      'submission emits success state',
      build: () => InfoCubit(),
      act: (cubit) {
        cubit.emit(cubit.state.copyWith(
            email: email,
            firstName: firstName,
            lastName: lastName,
            phoneCode: phoneCode,
            phoneNumber: phone,
            status: Formz.validate([
              email,
            ])));

        // ignore: cascade_invocations
        cubit.submitForm();
      },
      expect: () => [
        const InfoState(
          email: email,
          firstName: firstName,
          lastName: lastName,
          phoneCode: phoneCode,
          phoneNumber: phone,
          status: FormzStatus.valid,
        ),
        const InfoState(
          email: email,
          firstName: firstName,
          lastName: lastName,
          phoneCode: phoneCode,
          phoneNumber: phone,
          status: FormzStatus.submissionSuccess,
        ),
      ],
    );

    const wrongEmail = Email.dirty('email');

    blocTest<InfoCubit, InfoState>(
      'invalid submission emits failed state',
      build: () => InfoCubit(),
      act: (cubit) {
        cubit.emit(cubit.state.copyWith(
            email: wrongEmail,
            firstName: firstName,
            lastName: lastName,
            phoneCode: phoneCode,
            phoneNumber: phone,
            status: Formz.validate([
              wrongEmail,
            ])));

        // ignore: cascade_invocations
        cubit.submitForm();
      },
      expect: () => [
        const InfoState(
          email: wrongEmail,
          firstName: firstName,
          lastName: lastName,
          phoneCode: phoneCode,
          phoneNumber: phone,
          status: FormzStatus.invalid,
        ),
        const InfoState(
          email: wrongEmail,
          firstName: firstName,
          lastName: lastName,
          phoneCode: phoneCode,
          phoneNumber: phone,
          status: FormzStatus.submissionFailure,
        ),
      ],
    );
  });
}
