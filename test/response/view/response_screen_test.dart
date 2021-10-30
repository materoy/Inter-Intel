import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inter_intel_interview/app/utils/size_config.dart';
import 'package:inter_intel_interview/response/bloc/todo_bloc.dart';
import 'package:inter_intel_interview/response/model/todo.dart';
import 'package:inter_intel_interview/response/repository/todo_repository.dart';
import 'package:inter_intel_interview/response/view/response_screen.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/pump_app.dart';

class MockTodoBloc extends MockBloc<TodoEvent, TodoState> implements TodoBloc {}

class MockDio extends Mock implements Dio {}

class MockRepository extends Mock implements TodoRepository {
  MockRepository({required this.mockDio});

  final MockDio mockDio;

  @override
  Dio get dio => mockDio;
}

class MockResponse extends Mock implements Response<List<dynamic>> {}

void main() {
  group('response screen', () {
    testWidgets('renders response view', (tester) async {
      await tester.pumpApp(const ResponseScreen());
      await tester.pumpAndSettle();
      expect(find.byType(ResponseView), findsOneWidget);
    });
  });

  group('todo view', () {
    late TodoBloc todoBloc;
    late TodoRepository todoRepository;

    setUp(() {
      todoBloc = MockTodoBloc();
      todoRepository = MockRepository(mockDio: MockDio());
    });

    setUpAll(() {
      registerFallbackValue(const TodoLoadSuccess());
      registerFallbackValue(TodosLoaded());
    });

    testWidgets('renders n todos', (tester) async {
      const n = 4;

      when(() => todoRepository.loadTodos()).thenAnswer((invocation) async {
        return List<Todo>.generate(n, (index) {
          return const Todo(userId: 1, id: 2, title: 'title', completed: true);
        });
      });
      final todos = await todoRepository.loadTodos();
      when(() => todoBloc.state).thenReturn(TodoLoadSuccess(todos));

      await tester.pumpApp(Builder(builder: (context) {
        SizeConfig().initialize(context);
        return BlocProvider.value(
          value: todoBloc,
          child: const Material(child: ResponseView()),
        );
      }));
      await tester.pumpAndSettle();
      expect(find.byType(TodoCard), findsNWidgets(n));
    });
  });
}
