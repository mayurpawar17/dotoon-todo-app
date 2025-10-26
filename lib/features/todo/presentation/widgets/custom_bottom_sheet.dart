import 'package:dotoon_todo_app/core/widgets/custom_button.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/helper_method.dart';
import '../../domain/todo_Model.dart';
import '../../provider/priority_provider.dart';
import '../../provider/task_provider.dart';

class CustomBottomSheet extends StatefulWidget {
  final Todo? todo;

  const CustomBottomSheet({super.key, this.todo});

  @override
  _CustomBottomSheetState createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  @override
  void initState() {
    super.initState();

    if (widget.todo != null) {
      // Ensures this runs AFTER first frame to avoid build-time errors
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final taskProvider = Provider.of<TaskProvider>(context, listen: false);
        final priorityProvider = Provider.of<PriorityProvider>(
          context,
          listen: false,
        );
        taskProvider.loadTodo(widget.todo, priorityProvider);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
        ),
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 16,
          right: 16,
          top: 10,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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

                widget.todo != null
                    ? IconButton(
                      onPressed: () {
                        taskProvider.deleteTask(widget.todo!, context, isDark);
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
            Consumer<PriorityProvider>(
              builder: (context, priorityProvider, _) {
                return CustomButton(
                  text: widget.todo != null ? "Update Task" : "Save Task",
                  onTap: () {
                    final title = taskProvider.titleController.text.trim();
                    final note = taskProvider.noteController.text.trim();

                    if (title.isEmpty) return;

                    final priorityString = priorityProvider.priorityToString(
                      priorityProvider.selectedPriority,
                    );

                    if (widget.todo != null) {
                      taskProvider.updateTask(
                        Todo(
                          id: widget.todo!.id,
                          title: title,
                          note: note,
                          priority: priorityString,
                          isCompleted: widget.todo!.isCompleted,
                        ),
                      );
                    } else {
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
                  btnHeight: screenHeight * 0.07,
                  btnWidth: screenWidth * 1.0,
                  bgColor: HelperMethods.themeColor(context),
                  textColor: isDark ? Colors.black : Colors.white,
                );
              },
            ),
            SizedBox(height: screenHeight * 0.02),
          ],
        ),
      ),
    );
  }
}
