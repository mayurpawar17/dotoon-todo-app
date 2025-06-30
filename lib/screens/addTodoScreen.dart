import 'package:flutter/material.dart';

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
                    items: categories.keys.map((String category) {
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
                      child: const Text('Add Todo'),
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
