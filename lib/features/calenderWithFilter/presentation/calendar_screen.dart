import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../core/utils/helper_method.dart';
import '../../todo/presentation/widgets/custom_list_tile.dart';
import '../../todo/provider/task_provider.dart';

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
                        ? const Center(child: Text('No tasks for this date'))
                        : ListView.builder(
                          itemCount: taskProvider.tasks.length,
                          itemBuilder: (context, index) {
                            final todo =
                                taskProvider.tasksForSelectedDate[index];
                            return CustomListTile(
                              todo: todo,
                              isCompleted: todo.isCompleted,
                              onChanged: (val) {
                                // setState(() {
                                //   todo.isCompleted = val ?? false;
                                // });
                              },
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

  // List<Todo> get tasksForSelectedDate {
  //   return _tasks.where((task) {
  //     if (task.date == null) return false;
  //     return task.date!.year == _selectedDate.year &&
  //         task.date!.month == _selectedDate.month &&
  //         task.date!.day == _selectedDate.day;
  //   }).toList();
  // }
}
