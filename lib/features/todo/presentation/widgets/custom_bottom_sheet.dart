import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/helper_method.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../domain/todo_Model.dart';
import '../../provider/priority_provider.dart';
import '../../provider/task_provider.dart';

class CustomBottomSheet extends StatelessWidget {
  final Todo? todo; // nullable for editing
  const CustomBottomSheet({super.key, this.todo});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    final priorityProvider = Provider.of<PriorityProvider>(
      context,
      listen: false,
    );

    if (todo != null) {
      taskProvider.loadTodo(todo, priorityProvider);
    }

    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
        ),
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom, // avoid keyboard
          left: 16,
          right: 16,
          top: 10,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Title
            TextField(
              controller: taskProvider.titleController,
              cursorColor: HelperMethods.themeColor(context),
              autofocus: true,
              decoration: InputDecoration(
                hintText: "Type your next task here",
                hintStyle: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: HelperMethods.themeColor(context),
                ),
                border: InputBorder.none,
              ),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),

            //Note
            TextField(
              controller: taskProvider.noteController,
              cursorColor: HelperMethods.themeColor(context),
              decoration: InputDecoration(
                hintText: "Note",
                hintStyle: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: HelperMethods.themeColor(context),
                ),
                border: InputBorder.none,
              ),
            ),
            const SizedBox(height: 12),

            //Priority dropdown + icons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  height: 34,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 1.5,
                      color: HelperMethods.themeColor(context),
                    ),
                  ),
                  child: Consumer<PriorityProvider>(
                    builder: (context, priorityProvider, child) {
                      return DropdownButtonHideUnderline(
                        child: DropdownButton<PriorityLevel>(
                          icon: Icon(
                            EvaIcons.arrowDownOutline,
                            color: HelperMethods.themeColor(context),
                          ),
                          value: priorityProvider.selectedPriority,
                          items: const [
                            DropdownMenuItem(
                              value: PriorityLevel.low,
                              child: Text(
                                'Low',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            DropdownMenuItem(
                              value: PriorityLevel.medium,
                              child: Text(
                                'Medium',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            DropdownMenuItem(
                              value: PriorityLevel.high,
                              child: Text(
                                'High',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                          onChanged: (value) {
                            if (value != null) {
                              priorityProvider.updatePriority(value);
                            }
                            HapticFeedback.selectionClick();
                          },
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 8),
                // CustomIconButton(
                //   onTap: () {},
                //   text: 'Calendar',
                //   icon: EvaIcons.calendarOutline,
                // ),
                // const SizedBox(width: 8),
                // CustomIconButton(
                //   onTap: () {},
                //   text: 'Reminder',
                //   icon: EvaIcons.clockOutline,
                // ),
                todo != null
                    ? IconButton(
                      onPressed: () {
                        taskProvider.deleteTask(todo!, context, isDark);
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.delete,
                        color: HelperMethods.themeColor(context),
                      ),
                    )
                    : Container(),
              ],
            ),

            const SizedBox(height: 12),

            //Save / Update Button
            Consumer<PriorityProvider>(
              builder: (context, priorityProvider, _) {
                return CustomButton(
                  text: todo != null ? "Update Task" : "Save Task",
                  onTap: () {
                    final title = taskProvider.titleController.text.trim();
                    final note = taskProvider.noteController.text.trim();

                    if (title.isEmpty) return;

                    final priorityString = priorityProvider.priorityToString(
                      priorityProvider.selectedPriority,
                    );

                    if (todo != null) {
                      //Update
                      taskProvider.updateTask(
                        Todo(
                          id: todo!.id,
                          title: title,
                          note: note,
                          priority: priorityString,
                          isCompleted: todo!.isCompleted,
                        ),
                      );
                    } else {
                      // Save
                      taskProvider.saveTask(
                        Todo(
                          title: title,
                          note: note,
                          priority: priorityString,
                        ),
                      );
                    }

                    Navigator.pop(context);
                    taskProvider.clearEditing();
                  },
                  widget: Container(),
                );
              },
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
