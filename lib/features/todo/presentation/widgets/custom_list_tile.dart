import 'package:dotted_border/dotted_border.dart'
    show CustomPathDottedBorderOptions, DottedBorder;
import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  CustomListTile({super.key, this.index});

  final index;

  List<String> text = List.generate(20, (i) => 'Task $i');

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      options: CustomPathDottedBorderOptions(
        padding: const EdgeInsets.all(8),
        color: Colors.grey,
        strokeWidth: 2,
        dashPattern: [4, 4],
        customPath:
            (size) =>
                Path()
                  ..moveTo(0, size.height)
                  ..lineTo(size.width, size.height),
      ),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.check_circle_outline),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text[index],
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                const Text("This is a to-do item"),
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
