import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:inter_intel_interview/info/info.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserState(User.empty())) {
    on<UserLoaded>((event, emit) async {
      final userMap = await Dio().get<dynamic>('https://randomuser.me/api/');
      final user = User.fromMap(
          // ignore: avoid_dynamic_calls
          (userMap.data['results'] as List).first as Map<String, dynamic>);

      emit(UserLoadingSuccess(user));
    });
  }
}
