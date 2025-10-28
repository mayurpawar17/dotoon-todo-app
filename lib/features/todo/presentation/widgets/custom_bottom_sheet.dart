import 'package:dotoon_todo_app/features/todo/presentation/widgets/priority_selector_sheet.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/helper_method.dart';
import '../../../../core/widgets/custom_button.dart';
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
              cursorColor: HelperMethods.firstWhiteColor(context),
              autofocus: true,
              decoration: InputDecoration(
                hintText: " e.g. Type your next task here",
                hintStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  // color: HelperMethods.themeColor(context),
                  color: Colors.grey,
                ),
                border: InputBorder.none,
              ),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),

            TextField(
              controller: taskProvider.noteController,
              cursorColor: HelperMethods.firstWhiteColor(context),
              decoration: InputDecoration(
                hintText: "Note",
                hintStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
                border: InputBorder.none,
              ),
            ),
            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                      ),
                      builder: (_) => PrioritySelectorSheet(),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: HelperMethods.firstWhiteColor(context),
                        width: 0.5,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          EvaIcons.flagOutline,
                          color: HelperMethods.firstWhiteColor(context),
                        ),
                        const SizedBox(width: 8),
                        Consumer<PriorityProvider>(
                          builder: (context, pp, _) {
                            return Text(
                              pp.priorityToString(pp.selectedPriority),
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            );
                          },
                        ),
                        const Icon(Icons.keyboard_arrow_down_rounded, size: 20),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),

                widget.todo != null
                    ? IconButton(
                      onPressed: () {
                        taskProvider.deleteTask(widget.todo!, context);
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.delete, color: Colors.red),
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
                  bgColor: HelperMethods.firstWhiteColor(context),
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
