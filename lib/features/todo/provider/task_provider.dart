import 'package:dotoon_todo_app/features/todo/provider/priority_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/utils/helper_method.dart';
import '../../onboarding/data/onboarding_services.dart';
import '../data/database_helper.dart';
import '../domain/todo_Model.dart';

class TaskProvider extends ChangeNotifier {
  final OnBoardingServices _onBoardingServices = OnBoardingServices();

  late List<Todo> _tasks = [];

  final TextEditingController titleController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  String _name = '';

  List<Todo> get tasks => _tasks;

  List<Todo> get pendingTasks =>
      _tasks.where((todo) => !todo.isCompleted).toList();

  List<Todo> get completedTasks =>
      _tasks.where((todo) => todo.isCompleted).toList();

  String get name => _name;

  final String _title = '';
  final String _note = '';

  String get title => _title;

  String get description => _note;

  TaskProvider() {
    setName();
    fetchTodos();
  }

  void setName() async {
    _name = (await _onBoardingServices.loadName())!;
    notifyListeners();
  }

  void saveTask(Todo todo) async {
    _tasks.add(todo);
    int id = await DatabaseHelper.instance.insert(todo);
    print('Inserted todo with id: $id');
    HapticFeedback.selectionClick();
    notifyListeners();
  }

  void updateTask(Todo todo) {
    final index = _tasks.indexWhere((t) => t.id == todo.id);
    if (index != -1) {
      _tasks[index] = Todo(
        id: todo.id,
        title: todo.title,
        note: todo.note,
        priority: todo.priority,
        isCompleted: todo.isCompleted,
        date: _tasks[index].date,
      );
      DatabaseHelper.instance.update(_tasks[index]);
      HapticFeedback.selectionClick();

      notifyListeners();
    }
    clearEditing();
  }

  // To fetch all todos
  void fetchTodos() async {
    _tasks = await DatabaseHelper.instance.getAllTodos();
    notifyListeners();
  }

  // To update a todo
  void markAsComplete(Todo todo) async {
    final index = _tasks.indexWhere((t) => t.id == todo.id);
    if (index == -1) return;

    _tasks[index].isCompleted = !_tasks[index].isCompleted;
    int rowsAffected = await DatabaseHelper.instance.update(_tasks[index]);
    print('Updated $rowsAffected row(s)');
    HapticFeedback.selectionClick();
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

    // Then remove from database
    int rowsAffected = await DatabaseHelper.instance.delete(id);
    // print('Deleted $rowsAffected row(s)');

    // Then notify UI
    notifyListeners();
    HapticFeedback.selectionClick();
  }

  void loadTodo(Todo? todo, PriorityProvider priorityProvider) {
    if (todo != null) {
      titleController.text = todo.title;
      noteController.text = todo.note;

      // update priority using the priorityProvider
      priorityProvider.updatePriority(
        priorityProvider.stringToPriority(todo.priority),
      );

      notifyListeners();
    }
  }

  void deleteTask(Todo todo, BuildContext context, bool isDark) {
    removeTodo(todo.id);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Task deleted',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: HelperMethods.themeColor(context),
        action: SnackBarAction(
          label: 'Undo',
          textColor: isDark ? Colors.black : Colors.white,

          onPressed: () => saveTask(todo!),
        ),
      ),
    );
  }

  // Clear controllers after saving/updating
  void clearEditing() {
    titleController.clear();
    noteController.clear();
  }
}
