import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/helper_method.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_icon_button.dart';
import '../../domain/todo_Model.dart';
import '../../provider/task_provider.dart';

class CustomBottomSheet extends StatelessWidget {
  final Todo? todo; // nullable for editing
  const CustomBottomSheet({super.key, this.todo});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);

    // Controllers initialized with existing todo data if editing
    final TextEditingController _taskController = TextEditingController(
      text: todo?.title ?? '',
    );
    final TextEditingController _descriptionController = TextEditingController(
      text: todo?.description ?? '',
    );

    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
        ),
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom, // avoid keyboard
          left: 16,
          right: 16,
          top: 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _taskController,
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
              controller: _descriptionController,
              decoration: InputDecoration(
                hintText: "Description",
                hintStyle: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: HelperMethods.themeColor(context),
                ),
                border: InputBorder.none,
              ),
            ),
            const SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  CustomIconButton(
                    onTap: () {},
                    text: 'Calender',
                    icon: EvaIcons.calendarOutline,
                  ),
                  const SizedBox(width: 8),
                  CustomIconButton(
                    onTap: () {},
                    text: 'Priority',
                    icon: EvaIcons.flagOutline,
                  ),
                  const SizedBox(width: 8),
                  CustomIconButton(
                    onTap: () {},
                    text: 'Reminder',
                    icon: EvaIcons.clockOutline,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            CustomButton(
              text: todo != null ? "Update Task" : "Save Task",
              onTap: () {
                final title = _taskController.text.trim();
                final description = _descriptionController.text.trim();

                if (title.isEmpty) return; // require title

                if (todo != null) {
                  // Update existing todo
                  taskProvider.updateTask(
                    Todo(
                      id: todo!.id,
                      title: title,
                      description: description,
                      isCompleted: todo!.isCompleted,
                    ),
                  );
                } else {
                  // Save new todo
                  taskProvider.saveTask(
                    Todo(title: title, description: description),
                  );
                }

                Navigator.pop(context);
              },
              widget: Container(),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
