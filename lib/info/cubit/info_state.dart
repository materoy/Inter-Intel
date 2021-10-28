part of 'info_cubit.dart';

@immutable
class InfoState extends Equatable {
  const InfoState({
    this.firstName = '',
    this.lastName = '',
    this.email = const Email.pure(),
    this.phoneNumber = const Phone.pure(),
    this.status = FormzStatus.pure,
  });

  final String firstName;
  final String lastName;
  final Email email;
  final Phone phoneNumber;
  final FormzStatus status;

  InfoState copyWith(
          {String? firstName,
          String? lastName,
          Email? email,
          Phone? phoneNumber,
          FormzStatus? status}) =>
      InfoState(
          firstName: firstName ?? this.firstName,
          lastName: lastName ?? this.lastName,
          email: email ?? this.email,
          phoneNumber: phoneNumber ?? this.phoneNumber,
          status: status ?? this.status);

  @override
  List<Object?> get props => [firstName, lastName, email, phoneNumber, status];
}
