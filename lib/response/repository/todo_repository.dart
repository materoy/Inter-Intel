import 'package:dio/dio.dart';

import 'package:inter_intel_interview/response/model/todo.dart';

class TodoRepository {
  final Dio _dio = Dio();

  static const URL = 'https://jsonplaceholder.typicode.com/todos';

  Future<List<Todo>> loadTodos([int limit = 5]) async {
    final todos = List<Todo>.empty(growable: true);
    final response = await _dio.get<List>('$URL?_limit=$limit');

    if (response.data != null) {
      for (final todoMap in response.data!) {
        final todo = Todo.fromMap(todoMap as Map<String, dynamic>);
        todos.add(todo);
      }
    } else {
      throw Exception();
    }

    return todos;
  }
}
