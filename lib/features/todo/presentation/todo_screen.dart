import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:dotoon_todo_app/features/todo/presentation/widgets/custom_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../theme/presentation/settings_screen.dart';

class TodoScreen extends StatelessWidget {
  TodoScreen({super.key});

  final DateTime _selectedDate = DateTime.now();

  List<String> text = List.generate(20, (i) => 'Task $i');

  final List<String> _tasks = [];

  final TextEditingController _controller = TextEditingController();

  // void _openAddTaskSheet() {
  //   showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true, // 👈 expands with keyboard
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
  //     ),
  //     builder: (context) {
  //       return SafeArea(
  //         child: Padding(
  //           padding: EdgeInsets.only(
  //             bottom: MediaQuery.of(
  //               context,
  //             ).viewInsets.bottom, // avoid keyboard overlap
  //             left: 16,
  //             right: 16,
  //             top: 20,
  //           ),
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               const Text(
  //                 "Add Task",
  //                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  //               ),
  //               const SizedBox(height: 12),
  //               TextField(
  //                 controller: _controller,
  //                 autofocus: true,
  //                 decoration: InputDecoration(
  //                   hintText: "Enter task",
  //                   border: InputBorder.none,
  //                 ),
  //               ),
  //               const SizedBox(height: 12),
  //
  //               CustomButton(
  //                 text: 'Save Task',
  //                 onTap: () {},
  //                 widget: Icon(Icons.close, color: Colors.white),
  //               ),
  //               const SizedBox(height: 10),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 0.5;
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello Example',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
            ),

            Text(
              DateFormat('MMMM d, yyyy').format(_selectedDate),
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsScreen()),
              );
            },
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(thickness: 0.2),
              // Date Picker Timeline
              DatePicker(
                DateTime.now(),
                width: 60,
                height: 100,
                initialSelectedDate: DateTime.now(),
                selectionColor: Colors.black,
                selectedTextColor: Colors.white,
                onDateChange: (date) {
                  // update selected date
                },
              ),
              SizedBox(height: 10),

              Text(
                'To Do',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
              ),
              SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: text.length,
                  itemBuilder: (context, index) {
                    return CustomListTile(index: index);
                  },
                ),
              ),
              // SizedBox(height: 10),
              // Text(
              //   'Done',
              //   style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
              // ),
              // SizedBox(height: 10),
              // Expanded(
              //   child: ListView.builder(
              //     itemCount: text.length,
              //     itemBuilder: (context, index) {
              //       // return ListTile(title: Text(text[index]));
              //       return ListTile(
              //         title: Text(text[index]),
              //         subtitle: const Text("This is a to-do item"),
              //         trailing: const Icon(Icons.check_circle_outline),
              //       );
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        elevation: 0,
        // onPressed: _openAddTaskSheet,
        onPressed: () {},
        child: Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
