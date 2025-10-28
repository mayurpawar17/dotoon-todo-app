import 'package:dotted_border/dotted_border.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/date_time_helper_method.dart';
import '../../../../core/utils/helper_method.dart';
import '../../domain/todo_Model.dart';
import '../../provider/priority_provider.dart';
import '../../provider/task_provider.dart';
import '../../utils/bottom_sheet_helper.dart';

class CustomListTile extends StatelessWidget {
  CustomListTile({
    super.key,
    required this.todo,
    required this.isCompleted,
    this.onChanged,
  });

  final Todo todo; // single todo item
  final bool isCompleted; // checkbox state
  final Function? onChanged; // toggle callback

  final MenuController _menuController = MenuController();

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
                    color:
                        isCompleted
                            ? AppColors.primaryColorDarkMode
                            : Colors.transparent,
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
                        color: HelperMethods.firstWhiteColor(context),
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
                            color: HelperMethods.firstWhiteColor(context),
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
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: Text(
                              currentPriority,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: isTablet ? 15 : 9,
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
                          fontSize: isTablet ? 12 : 8,
                          color: Colors.grey[600],
                        ),
                      ),
                      Text(
                        DateTimeHelperMethod.formatTime(todo.date),
                        style: TextStyle(
                          fontSize: isTablet ? 12 : 8,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),

                  Builder(
                    builder: (scaffoldContext) {
                      return MenuAnchor(
                        style: MenuStyle(
                          fixedSize: WidgetStatePropertyAll(
                            Size(50, double.nan),
                          ),
                          padding: WidgetStateProperty.all(EdgeInsets.zero),
                          visualDensity: VisualDensity.compact,
                          backgroundColor: WidgetStateProperty.all(
                            HelperMethods.firstDarkSecondaryColor(context),
                          ),
                          elevation: WidgetStateProperty.all(1.0),
                          shape: WidgetStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        controller: _menuController,
                        builder: (context, controller, child) {
                          return IconButton(
                            icon: Icon(
                              Icons.more_vert,
                              color: HelperMethods.firstWhiteColor(context),
                            ),
                            tooltip: "Options",
                            onPressed: () {
                              if (controller.isOpen) {
                                controller.close();
                              } else {
                                HapticFeedback.selectionClick();
                                controller.open();
                              }
                            },
                          );
                        },
                        menuChildren: [
                          MenuItemButton(
                            style: ButtonStyle(
                              padding: WidgetStateProperty.all(
                                const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 6,
                                ),
                              ),
                              minimumSize: WidgetStateProperty.all(
                                const Size(0, 32),
                              ), // reduce height
                              visualDensity:
                                  VisualDensity.compact, // makes it tighter
                            ),
                            child: Icon(
                              EvaIcons.edit,
                              color: HelperMethods.firstWhiteColor(context),
                            ),
                            onPressed: () {
                              openAddTaskSheet(context, todo);
                              HapticFeedback.selectionClick();
                              _menuController.close();
                            },
                          ),
                          Consumer<TaskProvider>(
                            builder: (context, tp, _) {
                              return MenuItemButton(
                                style: ButtonStyle(
                                  padding: WidgetStateProperty.all(
                                    const EdgeInsets.symmetric(
                                      horizontal: 6,
                                      vertical: 6,
                                    ),
                                  ),
                                  minimumSize: WidgetStateProperty.all(
                                    const Size(0, 32),
                                  ), // reduce height
                                  visualDensity:
                                      VisualDensity.compact, // makes it tighter
                                ),
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.redAccent,
                                ),
                                onPressed: () {
                                  tp.deleteTask(todo, scaffoldContext);
                                  HapticFeedback.mediumImpact();
                                  _menuController.close();
                                },
                              );
                            },
                          ),
                        ],
                      );
                    },
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
