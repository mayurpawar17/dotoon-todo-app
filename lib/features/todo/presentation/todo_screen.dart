import 'package:dotoon_todo_app/features/todo/presentation/widgets/custom_bottom_sheet.dart';
import 'package:dotoon_todo_app/features/todo/presentation/widgets/custom_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/helper_method.dart';
import '../../onboarding/provider/onboarding_prodvider.dart';
import '../domain/todo_Model.dart';
import '../provider/task_provider.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> with TickerProviderStateMixin {
  late final AnimationController _animationController;
  final DateTime _currentDate = DateTime.now(); // track currently selected date

  @override
  void initState() {
    super.initState();
    _animationController = BottomSheet.createAnimationController(this);
    _animationController.duration = const Duration(milliseconds: 400);
    _animationController.reverseDuration = const Duration(milliseconds: 300);
    _animationController.drive(CurveTween(curve: Curves.easeInOut));
  }

  Todo? todo;

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 0.5;
    final taskProvider = Provider.of<TaskProvider>(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer<OnBoardingProvider>(
              builder: (context, onBoardingProvider, child) {
                return Text(
                  'Hello ${taskProvider.name}',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                );
              },
            ),

            Text(
              DateFormat('MMMM d, yyyy').format(_currentDate),
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(thickness: 0.2),

              // SizedBox(height: 10),
              Text(
                'To Do',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: HelperMethods.themeColor(context),
                ),
              ),
              SizedBox(height: 10),

              Expanded(
                child:
                    taskProvider.tasks.isEmpty
                        ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/no_task1.jpg', height: 300),

                              Text(
                                'Nothing here yet!',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: HelperMethods.themeColor(context),
                                ),
                              ),
                              Text(
                                'Add your first task and get started',
                                style: TextStyle(
                                  color: HelperMethods.themeColor(context),
                                ),
                              ),
                            ],
                          ),
                        )
                        : ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: taskProvider.tasks.length,
                          itemBuilder: (context, index) {
                            final todo = taskProvider.tasks[index];
                            return Dismissible(
                              key: ValueKey(todo.id),
                              background: Container(
                                alignment: Alignment.centerRight,
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                color: Colors.red,
                                child: Icon(Icons.delete, color: Colors.white),
                              ),

                              direction: DismissDirection.endToStart,
                              onDismissed: (direction) {
                                taskProvider.removeTodo(todo.id);

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor:
                                        isDark ? Colors.white : Colors.black,
                                    content: Text('Task deleted'),
                                    action: SnackBarAction(
                                      label: 'Undo',
                                      textColor:
                                          isDark ? Colors.black : Colors.white,
                                      onPressed: () {
                                        taskProvider.saveTask(todo);
                                      },
                                    ),
                                  ),
                                );
                              },
                              child: CustomListTile(
                                onTap: () {
                                  _openAddTaskSheet(context, todo);
                                  HapticFeedback.selectionClick();
                                },
                                todo: todo,
                                isCompleted: todo.isCompleted,
                                onChanged: () {
                                  taskProvider.markAsComplete(todo);
                                  HapticFeedback.lightImpact();
                                },
                              ),
                            );
                          },
                        ),
              ),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        elevation: 0,
        onPressed: () {
          _openAddTaskSheet(context, todo);
        },
        child: Icon(Icons.add, color: isDark ? Colors.black : Colors.white),
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _openAddTaskSheet(context, Todo? todo) {
    showModalBottomSheet(
      transitionAnimationController: _animationController,
      context: context,
      // expands with keyboard
      isScrollControlled: true,

      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return CustomBottomSheet(todo: todo);
      },
    );
  }
}
