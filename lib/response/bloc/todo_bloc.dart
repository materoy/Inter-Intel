import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:inter_intel_interview/response/model/todo.dart';
import 'package:inter_intel_interview/response/repository/todo_repository.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc({required this.todoRepository}) : super(TodoLoadInProgress()) {
    on<TodosLoaded>(_onTodosLoaded);
  }

  final TodoRepository todoRepository;

  Future<void> _onTodosLoaded(
      TodosLoaded event, Emitter<TodoState> emit) async {
    if (event is TodosLoaded) {
      try {
        final todos = await todoRepository.loadTodos();
        emit(TodoLoadSuccess(todos));
      } catch (_) {
        emit(TodoLoadFailure());
      }
    }
  }
}
