import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inter_intel_interview/response/bloc/todo_bloc.dart';
import 'package:inter_intel_interview/response/model/todo.dart';
import 'package:inter_intel_interview/response/repository/todo_repository.dart';

class ResponseScreen extends StatelessWidget {
  const ResponseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          TodoBloc(todoRepository: TodoRepository())..add(TodosLoaded()),
      child: const _ResponseView(),
    );
  }
}

class _ResponseView extends StatelessWidget {
  const _ResponseView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        if (state is TodoLoadInProgress) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        } else if (state is TodoLoadSuccess) {
          return ListView(
            children: List.generate(state.todos.length,
                (index) => TodoCard(todo: state.todos[index])),
          );
        } else {
          return const Center(child: Text('Failed to load data'));
        }
      },
    );
  }
}

class TodoCard extends StatelessWidget {
  const TodoCard({Key? key, required this.todo}) : super(key: key);

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(todo.title),
      trailing: Checkbox(
        value: todo.completed,
        onChanged: (value) {},
      ),
    );
  }
}
