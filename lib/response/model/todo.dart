import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  const Todo(
      {required this.userId,
      required this.id,
      required this.title,
      required this.completed});

  factory Todo.fromMap(Map<String, dynamic> todoMap) => Todo(
        userId: todoMap['userId'] as int,
        id: todoMap['id'] as int,
        title: todoMap['title'] as String,
        completed: todoMap['completed'] as bool,
      );

  final int userId;
  final int id;
  final String title;
  final bool completed;

  @override
  List<Object?> get props => [userId, id, title, completed];
}
