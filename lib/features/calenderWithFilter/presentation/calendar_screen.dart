import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../core/utils/helper_method.dart';
import '../../todo/presentation/widgets/custom_list_tile.dart';
import '../../todo/provider/task_provider.dart';
import '../../todo/utils/bottom_sheet_helper.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final taskProvider = Provider.of<TaskProvider>(context);
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(
                height: 300,
                child: SfDateRangePicker(
                  backgroundColor: isDark ? Colors.black : Colors.white,
                  // adapts
                  selectionColor: HelperMethods.themeColor(context),
                  startRangeSelectionColor: HelperMethods.themeColor(context),
                  endRangeSelectionColor: HelperMethods.themeColor(context),
                  todayHighlightColor: HelperMethods.themeColor(context),
                  rangeSelectionColor: HelperMethods.themeColor(context),
                  initialSelectedDate: taskProvider.selectedDate,

                  monthCellStyle: DateRangePickerMonthCellStyle(
                    textStyle: TextStyle(
                      color: isDark ? Colors.white70 : Colors.black87,
                    ),
                    todayTextStyle: TextStyle(
                      color: isDark ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    weekendTextStyle: TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.w500,
                    ),
                    disabledDatesTextStyle: TextStyle(
                      color: isDark ? Colors.white30 : Colors.black38,
                    ),
                  ),

                  headerStyle: DateRangePickerHeaderStyle(
                    textStyle: TextStyle(
                      color: isDark ? Colors.white : Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                    backgroundColor: isDark ? Colors.black : Colors.white,
                    textAlign: TextAlign.center,
                  ),
                  onSelectionChanged: (
                    DateRangePickerSelectionChangedArgs args,
                  ) {
                    if (args.value is DateTime) {
                      final selectedDate = args.value as DateTime;
                      taskProvider.setSelectedDate(selectedDate);
                    }
                  },
                  selectionMode: DateRangePickerSelectionMode.single,
                  initialSelectedRange: PickerDateRange(
                    DateTime.now().subtract(const Duration(days: 4)),
                    DateTime.now().add(const Duration(days: 3)),
                  ),
                ),
              ),

              // SizedBox(height: 20),
              Expanded(
                child:
                    taskProvider.tasksForSelectedDate.isEmpty
                        ? Center(
                          child: Column(
                            children: [
                              SizedBox(
                                height: screenHeight * 0.3,
                                child: Lottie.asset('assets/noTaskLottie.json'),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'No tasks for this date',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: HelperMethods.themeColor(context),
                                ),
                              ),
                            ],
                          ),
                        )
                        : ListView.builder(
                          itemCount: taskProvider.tasksForSelectedDate.length,
                          itemBuilder: (context, index) {
                            final todo =
                                taskProvider.tasksForSelectedDate[index];
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
                                taskProvider.deleteTask(todo, context, isDark);
                              },
                              child: CustomListTile(
                                todo: todo,
                                isCompleted: todo.isCompleted,
                                onChanged:
                                    () => taskProvider.markAsComplete(todo),
                                onTap: () => openAddTaskSheet(context, todo),
                              ),
                            );
                          },
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
