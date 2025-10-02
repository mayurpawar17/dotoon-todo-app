import 'package:dotoon/features/todo/presentation/bloc/todo_event.dart';
import 'package:dotoon/features/todo/presentation/bloc/todo_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc(super.initialState);
}
