import 'package:dotted_border/dotted_border.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/helper_method.dart';
import '../../domain/todo_Model.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.todo,
    required this.isCompleted,
    this.onChanged,
    this.onTap,
  });

  final Todo todo; // single todo item
  final bool isCompleted; // checkbox state
  final Function? onChanged; // toggle callback
  final onTap;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 600; // adjust layout for big screens
    return DottedBorder(
      options: CustomPathDottedBorderOptions(
        padding: const EdgeInsets.all(6),
        color: Colors.grey,
        strokeWidth: 1.5,
        dashPattern: [4, 4],
        customPath:
            (size) =>
                Path()
                  ..moveTo(0, size.height)
                  ..lineTo(size.width, size.height),
      ),
      child: Container(
        padding: EdgeInsets.all(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // const Icon(Icons.check_circle_outline),
            InkWell(
              onTap: () => onChanged?.call(),

              borderRadius: BorderRadius.circular(6),
              child: Container(
                height: 25,
                width: 25,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.0),
                  borderRadius: BorderRadius.circular(6),
                  color: isCompleted ? Colors.black : Colors.transparent,
                ),
                child:
                    isCompleted
                        ? const Icon(Icons.check, size: 16, color: Colors.white)
                        : null,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    todo.title,
                    style: TextStyle(
                      decoration:
                          isCompleted
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                      decorationThickness: 6,

                      fontWeight: FontWeight.w700,
                      color: HelperMethods.themeColor(context),
                    ),
                  ),
                  todo.description.isNotEmpty
                      ? Text(
                        todo.description,

                        // todo.description.isNotEmpty ? todo.description : "",
                        style: TextStyle(
                          decoration:
                              isCompleted
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                          decorationThickness: 3,
                          color: HelperMethods.themeColor(context),
                        ),
                      )
                      : Container(),
                ],
              ),
            ),

            const Spacer(),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 3,
                        vertical: 0.2,
                      ),
                      decoration: BoxDecoration(
                        color:
                            todo.priority == 'L'
                                ? Colors.green
                                : Colors.transparent,
                        borderRadius: BorderRadius.circular(4),
                      ),

                      child: Text(
                        todo.priority,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: isTablet ? 16 : 13,
                        ),
                      ),
                    ),
                    Text(
                      todo.date != null
                          ? DateFormat('hh:mm a').format(
                            todo.date!,
                          ) // 12-hour format with AM/PM
                          : 'No time',
                      style: TextStyle(
                        fontSize: isTablet ? 14 : 11,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 5),
                GestureDetector(
                  onTap: onTap,
                  child: Icon(EvaIcons.editOutline),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ListTile(
// leading: const Icon(Icons.check_circle_outline),
// title: Text(text[index], style: TextStyle(fontWeight: FontWeight.w700)),
// subtitle: const Text("This is a to-do item"),
// // trailing: const Icon(Icons.check_circle_outline),
// )
