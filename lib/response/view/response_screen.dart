import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inter_intel_interview/app/utils/size_config.dart';
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
      child: const ResponseView(),
    );
  }
}

class ResponseView extends StatelessWidget {
  const ResponseView({Key? key}) : super(key: key);

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
            children: List.generate(
              state.todos.length,
              (index) => TodoCard(
                todo: state.todos[index],
                index: index + 1,
              ),
            ),
          );
        } else {
          return const Center(child: Text('Failed to load data'));
        }
      },
    );
  }
}

class TodoCard extends StatelessWidget {
  const TodoCard({Key? key, required this.todo, required this.index})
      : super(key: key);

  final Todo todo;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: SizeConfig.unitHeight * 1,
          horizontal: SizeConfig.unitWidth * 5),
      padding: EdgeInsets.symmetric(
          vertical: SizeConfig.unitHeight * 2,
          horizontal: SizeConfig.unitWidth * 3),
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor.withOpacity(.4),
          borderRadius: BorderRadius.circular(20)),
      child: ListTile(
          title: Text(
            todo.title,
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                decoration: todo.completed ? TextDecoration.lineThrough : null),
          ),
          trailing: todo.completed
              ? const Icon(
                  CupertinoIcons.check_mark_circled,
                  color: Colors.green,
                  size: 30,
                )
              : null),
    );
  }
}
