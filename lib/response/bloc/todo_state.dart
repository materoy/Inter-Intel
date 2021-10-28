part of 'todo_bloc.dart';

abstract class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object> get props => [];
}

class TodoLoadInProgress extends TodoState {}

class TodoLoadSuccess extends TodoState {
  const TodoLoadSuccess([this.todos = const []]);
  final List<Todo> todos;

  @override
  List<Object> get props => [todos];
}

class TodoLoadFailure extends TodoState {}
