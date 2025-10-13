import 'package:dotoon_todo_app/features/todo/provider/task_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomChips extends StatelessWidget {
  final onTap;
  final String text;

  CustomChips({super.key, this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Consumer<TaskProvider>(
        builder: (context, taskProvider, child) {
          bool isSelected = false;

          return Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              // border: Border.all(color: Colors.white),
              color: isSelected ? Colors.white : Colors.transparent,
            ),
            child: Text(
              text,
              style: TextStyle(color: isSelected ? Colors.black : Colors.white),
            ),
          );
        },
      ),
    );
  }
}
