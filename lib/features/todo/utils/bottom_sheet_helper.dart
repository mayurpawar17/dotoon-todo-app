import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../domain/todo_Model.dart';
import '../presentation/widgets/custom_bottom_sheet.dart';
import '../provider/priority_provider.dart';
import '../provider/task_provider.dart';

void openAddTaskSheet(context, Todo? todo) {
  final taskProvider = Provider.of<TaskProvider>(context, listen: false);
  final priorityProvider = Provider.of<PriorityProvider>(
    context,
    listen: false,
  );

  //Clear everything before opening new bottom sheet
  taskProvider.clearEditing();
  priorityProvider.updatePriority(
    PriorityLevel.low,
  ); // reset dropdown to default
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return CustomBottomSheet(todo: todo);
    },
  );
  HapticFeedback.selectionClick();
}
