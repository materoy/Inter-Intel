import 'package:flutter_test/flutter_test.dart';
import 'package:inter_intel_interview/response/bloc/todo_bloc.dart';
import 'package:inter_intel_interview/response/repository/todo_repository.dart';

void main() {
  group('Todo bloc', () {
    final todoBloc = TodoBloc(todoRepository: TodoRepository());
    test('initial state is loading ', () {
      expect(todoBloc.state, TodoLoadInProgress());
    });
  });
}
