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
  List<Todo> todo = [];
  TextEditingController taskController = TextEditingController();
  final uuid = Uuid();

  void saveTodo(String title) {
    if (title.trim().isEmpty) return;

    todo.add(Todo(id: uuid.v4(), title: title, description: 'No Description'));

    setState(() {});
    taskController.clear();
  }

  // Future<String> loadUsername() async {
  //   final pref = await SharedPreferences.getInstance();
  //   return pref.getString('USERNAME') ?? 'null username';
  // }

  void loadUsername() async {
    final pref = await SharedPreferences.getInstance();
    final name = pref.getString('USERNAME') ?? 'null username';

    setState(() {
      username = name;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadUsername();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          username == null ? 'Hello...' : 'Hello $username',
          style: TextStyle(color: whiteColor, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  transitionDuration: Duration(milliseconds: 300),
                  transitionsBuilder: (context, ani, secondAni, child) {
                    return FadeTransition(opacity: ani, child: child);
                  },
                  pageBuilder: (context, ani, secondAni) => SettingsScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
                    todo.isEmpty
                        ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/no_task.svg',
                                height: 200,
                              ),
                              SizedBox(height: 30),
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
                          itemCount: todo.length,
                          itemBuilder: (context, index) {
                            final item = todo[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Dismissible(
                                key: Key(item.id),
                                onDismissed: (direction) {
                                  if (direction ==
                                      DismissDirection.startToEnd) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Archived')),
                                    );
                                    setState(() => todo.removeAt(index));
                                  } else {
                                    setState(() => todo.removeAt(index));
                                  }
                                },
                                direction: DismissDirection.horizontal,
                                background: Container(
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  color: Colors.green,
                                  child: Icon(
                                    Icons.archive,
                                    color: Colors.white,
                                  ),
                                ),
                                secondaryBackground: Container(
                                  alignment: Alignment.centerRight,
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  color: Colors.red,
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                ),
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
        onPressed:
            () => {
              showAddTaskModal(context, (Todo newTask) {
                setState(() {
                  todo.add(newTask);
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Task "${newTask.title}" added!')),
                );
              }),
            },
        child: const Icon(Icons.add, color: Colors.black),
      ),
    );
  }

  Widget _buildTodoItemCard(Todo item) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      // margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: todoItemCardColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.title,
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
              Text(
                item.description,
                style: const TextStyle(color: Colors.white70, fontSize: 16),
              ),
            ],
          ),
          Checkbox(value: true, onChanged: (value) {}),
        ],
      ),
    );
  }
}

void showAddTaskModal(BuildContext context, Function(Todo) onTaskCreated) {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final uuid = Uuid();

  showModalBottomSheet(
    backgroundColor: todoItemCardColor,
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (BuildContext context) {
      return SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.40, // 65% of screen
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Task Name',
                  style: TextStyle(fontSize: 16, color: fontGrey),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  height: MediaQuery.of(context).size.height * 0.06,
                  decoration: BoxDecoration(
                    color: bgColor,
                    border: Border.all(color: fontGrey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: TextField(
                      decoration: InputDecoration(border: InputBorder.none),
                      style: TextStyle(color: whiteColor),
                      controller: titleController,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  'Description',
                  style: TextStyle(fontSize: 16, color: fontGrey),
                ),
                TextField(
                  style: TextStyle(color: whiteColor),
                  controller: descriptionController,

                  // maxLines: 3,
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: whiteColor,
                    ),
                    onPressed: () {
                      final title = titleController.text.trim();
                      final description = descriptionController.text.trim();

                      if (title.isEmpty || description.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please enter both fields'),
                          ),
                        );
                        return;
                      }

                      final newTask = Todo(
                        id: uuid.v4(),
                        title: title,
                        description: description,
                      );

                      onTaskCreated(newTask);
                      Navigator.pop(context);
                    },
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
      );
    },
  );
}
