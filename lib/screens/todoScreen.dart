import 'package:dotoon_todo_app/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../constants/appColors.dart';
import '../model/todoModel.dart';

class TodoScreen extends StatefulWidget {
  static const Color cardColor = Colors.white70;

  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  String? username;
  List<Todo> todos = [];
  final uuid = const Uuid();

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  // Load the stored username from SharedPreferences
  Future<void> _loadUsername() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString('USERNAME') ?? 'User';
    setState(() {
      username = name;
    });
  }

  // Add a new todo task to the list
  void _addTodo(Todo todo) {
    setState(() {
      todos.add(todo);
    });
  }

  // Remove todo by index, optionally show snackbar
  void _removeTodoAt(int index, {String? message}) {
    final removedTask = todos[index];
    setState(() {
      todos.removeAt(index);
    });
    if (message != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$message "${removedTask.title}"')),
      );
    }
  }

  // Toggle completion status of a todo
  void _toggleTodoCompletion(Todo todo, bool? isChecked) {
    setState(() {
      todo.isCompleted = isChecked ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isTaskListEmpty = todos.isEmpty;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          username == null ? 'Hello...' : 'Hello, $username',
          style: const TextStyle(
            color: whiteColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 300),
                  transitionsBuilder:
                      (context, animation, _, child) =>
                          FadeTransition(opacity: animation, child: child),
                  pageBuilder: (context, _, __) => const SettingsScreen(),
                ),
              );
            },
          ),
        ],
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const Text(
                'Manage Your \nDaily Task',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child:
                    isTaskListEmpty
                        ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/no_task.svg',
                                height: 200,
                              ),
                              const SizedBox(height: 30),
                              Text(
                                'Add Task',
                                style: TextStyle(
                                  color: whiteColor,
                                  fontSize: 25,
                                ),
                              ),
                            ],
                          ),
                        )
                        : ListView.builder(
                          itemCount: todos.length,
                          itemBuilder: (context, index) {
                            final item = todos[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Dismissible(
                                key: Key(item.id),
                                background: Container(
                                  alignment: Alignment.centerLeft,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  color: Colors.green,
                                  child: const Icon(
                                    Icons.archive,
                                    color: Colors.white,
                                  ),
                                ),
                                secondaryBackground: Container(
                                  alignment: Alignment.centerRight,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  color: Colors.red,
                                  child: const Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                ),
                                direction: DismissDirection.horizontal,
                                onDismissed: (direction) {
                                  if (direction ==
                                      DismissDirection.startToEnd) {
                                    // Archive action - currently just removes and shows snackbar
                                    _removeTodoAt(index, message: 'Archived');
                                  } else {
                                    // Delete action
                                    _removeTodoAt(index, message: 'Deleted');
                                  }
                                },
                                child: _buildTodoItemCard(item),
                              ),
                            );
                          },
                        ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          showAddTaskModal(context, (Todo newTask) {
            _addTodo(newTask);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Task "${newTask.title}" added!')),
            );
          });
        },
        child: const Icon(Icons.add, color: Colors.black),
      ),
    );
  }

  // Widget to build each todo item card
  Widget _buildTodoItemCard(Todo item) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: todoItemCardColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  item.description,
                  style: const TextStyle(color: Colors.white70, fontSize: 16),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Checkbox(
            value: item.isCompleted,
            onChanged: (bool? checked) => _toggleTodoCompletion(item, checked),
            activeColor: whiteColor,
            checkColor: Colors.black,
          ),
        ],
      ),
    );
  }
}

void showAddTaskModal(BuildContext context, Function(Todo) onTaskCreated) {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final uuid = const Uuid();

  showModalBottomSheet(
    backgroundColor: todoItemCardColor,
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setModalState) {
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
              ),
              child: SingleChildScrollView(
                child: SizedBox(
                  // Fixed min height to avoid overflow but flexible in scrolling
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Task Name',
                        style: TextStyle(fontSize: 16, color: fontGrey),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        height: 50,
                        decoration: BoxDecoration(
                          color: bgColor,
                          border: Border.all(color: fontGrey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: TextField(
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                            style: const TextStyle(color: whiteColor),
                            controller: titleController,
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        'Description',
                        style: TextStyle(fontSize: 16, color: fontGrey),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: bgColor,
                          border: Border.all(color: fontGrey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextField(
                          maxLines: 3,
                          style: const TextStyle(color: whiteColor),
                          controller: descriptionController,
                          textInputAction: TextInputAction.done,
                          onSubmitted:
                              (_) => _attemptCreateTask(
                                context,
                                titleController,
                                descriptionController,
                                onTaskCreated,
                              ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: whiteColor,
                          ),
                          onPressed:
                              () => _attemptCreateTask(
                                context,
                                titleController,
                                descriptionController,
                                onTaskCreated,
                              ),
                          child: const Text(
                            'Create Task',
                            style: TextStyle(color: bgColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    },
  );
}

// Helper method to validate inputs and create the task
void _attemptCreateTask(
  BuildContext context,
  TextEditingController titleController,
  TextEditingController descriptionController,
  Function(Todo) onTaskCreated,
) {
  final title = titleController.text.trim();
  final description = descriptionController.text.trim();

  if (title.isEmpty || description.isEmpty) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Please enter both fields')));
    return;
  }

  final newTask = Todo(
    id: const Uuid().v4(),
    title: title,
    description: description,
    isCompleted: false,
  );

  onTaskCreated(newTask);
  Navigator.pop(context);
}
