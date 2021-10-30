part of 'user_bloc.dart';

class UserState extends Equatable {
  const UserState(this.user);

  final User user;

  @override
  List<Object> get props => [user];
}

class UserLoadingSuccess extends UserState {
  const UserLoadingSuccess(User user) : super(user);
}
