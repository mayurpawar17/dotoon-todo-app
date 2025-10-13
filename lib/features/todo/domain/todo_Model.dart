import 'package:uuid/uuid.dart';

class Todo {
  String id;
  String title;
  String description;
  String priority;
  DateTime date;
  bool isCompleted;

  Todo({
    String? id,
    required this.title,
    this.description = '',
    DateTime? date,
    this.priority = 'L',
    this.isCompleted = false,
  }) : id = id ?? const Uuid().v4(),
       date = date ?? DateTime.now();

  // Convert a Todo object into a Map object
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'priority': priority,
      'date': date.toIso8601String(), // Store DateTime as a String
      'isCompleted': isCompleted ? 1 : 0, // Store bool as an integer (0 or 1)
    };
  }

  // Extract a Todo object from a Map object
  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      priority: map['priority'],
      date: DateTime.parse(map['date']),
      // Parse the String back to DateTime
      isCompleted: map['isCompleted'] == 1, // Convert integer back to bool
    );
  }
}
