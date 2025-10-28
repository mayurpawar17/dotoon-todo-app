import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/helper_method.dart';
import '../../../onboarding/provider/onboarding_provider.dart';
import '../../domain/todo_Model.dart';
import '../../provider/chip_filter_provider.dart';
import '../../provider/task_provider.dart';
import '../../utils/bottom_sheet_helper.dart';
import '../widgets/custom_chips.dart';
import '../widgets/custom_list_tile.dart';

class TodoScreen extends StatelessWidget {
  TodoScreen({super.key});

  final DateTime _currentDate = DateTime.now();
  Todo? todo;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final taskProvider = Provider.of<TaskProvider>(context);
    final chipFilterProvider = Provider.of<ChipFilterProvider>(context);
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
                  'Hello ${onBoardingProvider.name}',
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
                'Tasks',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: HelperMethods.firstWhiteColor(context),
                ),
              ),
              SizedBox(height: 10),
              Consumer<ChipFilterProvider>(
                builder: (context, chipFilterProvider, child) {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children:
                        chipFilterProvider.chipOptions.map((option) {
                          final label = option['label'];
                          final filter = option['filter'] as TodoFilter;
                          return CustomChips(
                            text: label,
                            selected:
                                chipFilterProvider.selectedFilter == filter,
                            onTap: () {
                              chipFilterProvider.updateFilter(filter);
                            },
                          );
                        }).toList(),
                  );
                },
              ),
              SizedBox(height: 10),

              Expanded(
                child: Builder(
                  builder: (context) {
                    if (taskProvider.tasks.isEmpty) {
                      return Center(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: screenHeight * 0.3,
                                child: Lottie.asset('assets/noTaskLottie.json'),
                              ),
                              const SizedBox(height: 10),

                              Text(
                                'Nothing here yet!',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                  color: HelperMethods.firstWhiteColor(context),
                                ),
                              ),
                              Text(
                                'Add your first task and get started',
                                style: TextStyle(
                                  color: HelperMethods.firstWhiteColor(context),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    final selected = chipFilterProvider.selectedFilter;
                    List<Todo> displayList;

                    switch (selected) {
                      case TodoFilter.all:
                        displayList = taskProvider.tasks;
                        break;
                      case TodoFilter.pending:
                        displayList = taskProvider.pendingTasks;
                        break;
                      case TodoFilter.completed:
                        displayList = taskProvider.completedTasks;
                        break;
                    }

                    if (displayList.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: screenHeight * 0.3,
                              child: Lottie.asset('assets/noTaskLottie.json'),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'No ${selected == TodoFilter.completed ? 'Completed' : 'Pending'} tasks found!',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                                color: HelperMethods.firstWhiteColor(context),
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    // Show filtered list
                    return ListView.builder(
                      itemCount: displayList.length,
                      itemBuilder: (context, index) {
                        final todo = displayList[index];
                        return CustomListTile(
                          todo: todo,
                          isCompleted: todo.isCompleted,
                          onChanged: () => taskProvider.markAsComplete(todo),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openAddTaskSheet(context, todo);
        },
        child: Icon(
          Icons.add,
          color: HelperMethods.firstDarkIconColor(context),
        ),
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
