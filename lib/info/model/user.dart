import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User(
      {required this.firstName,
      required this.lastName,
      required this.email,
      this.picture = 'https://thispersondoesnotexist.com/image',
      required this.phoneNumber});

  factory User.empty() =>
      const User(firstName: '', lastName: '', email: '', phoneNumber: '');

  factory User.fromMap(Map<String, dynamic> userMap) {
    return User(
      firstName: (userMap['name'] as Map)['first'] as String,
      lastName: (userMap['name'] as Map)['last'] as String,
      email: userMap['email'] as String,
      phoneNumber: userMap['phone'] as String,
      picture: (userMap['picture'] as Map)['medium'] as String,
    );
  }

  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String picture;

  @override
  List<Object?> get props => [firstName, lastName, email, phoneNumber];
}
