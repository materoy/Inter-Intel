import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inter_intel_interview/response/bloc/todo_bloc.dart';
import 'package:inter_intel_interview/response/repository/todo_repository.dart';

void main() {
  group('Todo bloc', () {
    final todoBloc = TodoBloc(todoRepository: TodoRepository());
    test('initial state is loading ', () {
      expect(todoBloc.state, TodoLoadInProgress());
    });

    blocTest<TodoBloc, TodoState>(
      'loads todos',
      build: () => todoBloc..add(TodosLoaded()),
      act: (bloc) {
        bloc.add(TodosLoaded());
      },
      expect: () async {
        final todos = await TodoRepository().loadTodos();
        return [TodoLoadSuccess(todos)];
      },
    );
  });
}
