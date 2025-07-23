import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../widgets/todoTile.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(child: Column(children: [Text('Hello world')])),
      appBar: AppBar(
        title: GradientText(
          'Dotoon',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          colors: [Colors.deepPurpleAccent, Colors.blue, Colors.purpleAccent],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigator.of(context).push(
          //   MaterialPageRoute(builder: (context) => const AddTodoScreen()),
          // );

          showAddTodoBottomSheet(context);
        },
        backgroundColor: Colors.black,
        child: const Icon(Icons.add, size: 30, color: Colors.white),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Todo',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              const TodoTile(
                title: 'Submit 2023 tax return',
                subtitle: '💰 Finance',
              ),
              const TodoTile(
                title: 'Sign contract, send back',
                subtitle: '🖋️ Freelance',
              ),
              const TodoTile(
                title: 'Hand sanitizer',
                subtitle: '🛒 Shopping List',
              ),

              const SizedBox(height: 24),

              const Text(
                'Done',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              const TodoTile(
                title: 'UX Design meeting',
                subtitle: '🍥 Design',
                isDone: true,
              ),
            ],
          ),
        ),
      ),
    );
    ;
  }
}

void showAddTodoBottomSheet(BuildContext context) {
  final TextEditingController titleController = TextEditingController();
  String selectedCategory = 'Finance';

  final Map<String, String> categories = {
    'Finance': '💰',
    'Freelance': '🖋️',
    'Shopping List': '🛒',
    'Design': '🍥',
  };

  showModalBottomSheet(
    context: context,
    isScrollControlled: true, // for full height on keyboard open
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: StatefulBuilder(
          builder: (context, setState) {
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Handle bar
                  Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),

                  // Title Input
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      labelText: 'Task Title',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Category Dropdown
                  DropdownButtonFormField<String>(
                    value: selectedCategory,
                    decoration: const InputDecoration(
                      labelText: 'Category',
                      border: OutlineInputBorder(),
                    ),
                    items:
                        categories.keys.map((String category) {
                          return DropdownMenuItem<String>(
                            value: category,
                            child: Text('${categories[category]} $category'),
                          );
                        }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedCategory = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 20),

                  // Submit Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        final title = titleController.text.trim();
                        final icon = categories[selectedCategory];

                        if (title.isNotEmpty) {
                          Navigator.pop(context, {
                            'title': title,
                            'subtitle': '$icon $selectedCategory',
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text(
                        'Add Todo',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    },
  );
}

Widget showDrawer() {
  return Drawer(child: Column(children: [Text('Hello world')]));
}
