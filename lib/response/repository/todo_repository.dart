import 'package:dio/dio.dart';

import 'package:inter_intel_interview/response/model/todo.dart';

class TodoRepository {
  TodoRepository({Dio? dio}) {
    if (dio == null) {
      this.dio = Dio();
    } else {
      this.dio = dio;
    }
  }
  late final Dio dio;

  static const URL = 'https://jsonplaceholder.typicode.com/todos';

  Future<List<Todo>> loadTodos([int limit = 5]) async {
    final todos = List<Todo>.empty(growable: true);
    final response = await dio.get<List>('$URL?_limit=$limit');

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
