import 'package:dotted_border/dotted_border.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/date_time_helper_method.dart';
import '../../../../core/utils/helper_method.dart';
import '../../domain/todo_Model.dart';
import '../../provider/priority_provider.dart';

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
        padding: const EdgeInsets.all(0),
        color: Colors.grey,
        strokeWidth: 1.5,
        dashPattern: [4, 4],
        customPath:
            (size) =>
                Path()
                  ..moveTo(0, size.height)
                  ..lineTo(size.width, size.height),
      ),
      child: InkWell(
        onTap: () => onChanged?.call(),
        borderRadius: BorderRadius.circular(6),

        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 3),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                          ? const Icon(
                            Icons.check,
                            size: 16,
                            color: Colors.white,
                          )
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
                    todo.note.isNotEmpty
                        ? Text(
                          todo.note,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Consumer<PriorityProvider>(
                        builder: (context, priorityProvider, child) {
                          String currentPriority = todo.priority;

                          Color bgColor;
                          switch (currentPriority) {
                            case 'High':
                              bgColor = Colors.red;
                              break;
                            case 'Medium':
                              bgColor = Colors.orange;
                              break;
                            case 'Low':
                              bgColor = Colors.green;
                              break;
                            default:
                              bgColor = Colors.grey;
                          }

                          return Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 3,
                              vertical: 0.2,
                            ),
                            decoration: BoxDecoration(
                              color: bgColor,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              currentPriority,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: isTablet ? 15 : 10,
                                color: Colors.white,
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 2),

                      Text(
                        DateTimeHelperMethod.formatDate(todo.date),
                        style: TextStyle(
                          fontSize: isTablet ? 14 : 9,
                          color: Colors.grey[600],
                        ),
                      ),
                      Text(
                        DateTimeHelperMethod.formatTime(todo.date),
                        style: TextStyle(
                          fontSize: isTablet ? 14 : 9,
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
      ),
    );
  }
}
