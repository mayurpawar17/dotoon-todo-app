import 'package:flutter/material.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.black),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Menu',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close),
                  ),
                ],
              ),
            ),
            const ListTile(leading: Icon(Icons.home), title: Text('Home')),
            const ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
            ),
          ],
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
              // Top UI with menu icon opening drawer
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      // Make menu icon tappable
                      IconButton(
                        icon: const Icon(Icons.menu, size: 28),
                        onPressed: () {
                          _scaffoldKey.currentState?.openDrawer();
                        },
                      ),
                      const SizedBox(width: 4),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '18th Jan 2024',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                          const Text(
                            'Monday',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Icon(Icons.notifications_none, size: 28),
                ],
              ),

              const SizedBox(height: 24),

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
  }
}

class TodoTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isDone;

  const TodoTile({
    super.key,
    required this.title,
    required this.subtitle,
    this.isDone = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(value: isDone, onChanged: (_) {}, activeColor: Colors.black),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                decoration:
                    isDone ? TextDecoration.lineThrough : TextDecoration.none,
                color: isDone ? Colors.grey : Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ],
        ),
      ],
    );
  }
}

void showAddTodoBottomSheet(BuildContext context) {
  final TextEditingController _titleController = TextEditingController();
  String _selectedCategory = 'Finance';

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
                    controller: _titleController,
                    decoration: const InputDecoration(
                      labelText: 'Task Title',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Category Dropdown
                  DropdownButtonFormField<String>(
                    value: _selectedCategory,
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
                        _selectedCategory = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 20),

                  // Submit Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        final title = _titleController.text.trim();
                        final icon = categories[_selectedCategory];

                        if (title.isNotEmpty) {
                          Navigator.pop(context, {
                            'title': title,
                            'subtitle': '$icon $_selectedCategory',
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text('Add Todo',style: TextStyle(color: Colors.white),),
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
