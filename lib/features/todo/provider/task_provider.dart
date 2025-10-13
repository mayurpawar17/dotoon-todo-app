import 'package:flutter/cupertino.dart';

import '../../onboarding/data/onboarding_services.dart';
import '../data/database_helper.dart';
import '../domain/todo_Model.dart';

enum TodoFilter { all, pending, completed }

class TaskProvider extends ChangeNotifier {
  final OnBoardingServices _onBoardingServices = OnBoardingServices();
  late List<Todo> _tasks = [];

  String _name = '';

  List<Todo> get tasks => _tasks;
  List<Todo> get pendingTasks =>
      _tasks.where((todo) => !todo.isCompleted).toList();

  List<Todo> get completedTasks =>
      _tasks.where((todo) => todo.isCompleted).toList();

  String get name => _name;

  String _title = '';
  String _description = '';

  String get title => _title;

  String get description => _description;

  TaskProvider() {
    fetchTodos();
    setName();
  }

  void setName() async {
    _name = (await _onBoardingServices.loadName())!;
    notifyListeners();
  }

  void saveTask(Todo todo) async {
    _tasks.add(todo);
    int id = await DatabaseHelper.instance.insert(todo);
    print('Inserted todo with id: $id');

    notifyListeners();
  }

  void updateTask(Todo todo) {
    final index = _tasks.indexWhere((t) => t.id == todo.id);
    if (index != -1) {
      _tasks[index] = Todo(
        id: todo.id,
        title: todo.title,
        description: todo.description,
        isCompleted: todo.isCompleted,
      );
      notifyListeners();
    }
  }

  // To fetch all todos
  void fetchTodos() async {
    _tasks = await DatabaseHelper.instance.getAllTodos();
    notifyListeners();
    // _tasks.forEach((todo) {
    //   print(
    //     'Todo ID: ${todo.id} Todo: ${todo.title}, Completed: ${todo.isCompleted}',
    //   );
    // });
  }

  // To update a todo
  void markAsComplete(Todo todo) async {
    final index = _tasks.indexWhere((t) => t.id == todo.id);
    if (index == -1) return;

    _tasks[index].isCompleted = !_tasks[index].isCompleted;
    int rowsAffected = await DatabaseHelper.instance.update(_tasks[index]);
    print('Updated $rowsAffected row(s)');
    notifyListeners();
  }

  late DateTime _selectedDate = DateTime.now();

  DateTime get selectedDate => _selectedDate;

  void setSelectedDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  List<Todo> get tasksForSelectedDate {
    return _tasks.where((task) {
      if (task.date == null) return false;
      return task.date!.year == _selectedDate.year &&
          task.date!.month == _selectedDate.month &&
          task.date!.day == _selectedDate.day;
    }).toList();
  }

  // To delete a todo
  void removeTodo(String id) async {
    // First remove from the list
    _tasks.removeWhere((todo) => todo.id == id);

    // Then notify UI
    notifyListeners();

    // Then remove from database
    int rowsAffected = await DatabaseHelper.instance.delete(id);
    print('Deleted $rowsAffected row(s)');
  }
}
