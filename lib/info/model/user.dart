import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.phoneNumber});

  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;

  @override
  List<Object?> get props => [firstName, lastName, email, phoneNumber];
}
