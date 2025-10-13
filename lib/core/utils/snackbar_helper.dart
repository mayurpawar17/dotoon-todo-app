import 'package:flutter/material.dart';

/// Shows a modern, floating, and customizable SnackBar.
///
/// [context] is the BuildContext from where the SnackBar is triggered.
/// [message] is the text content to display.
/// [iconData] is the icon to show next to the message.
/// [iconColor] is the color of the icon.
/// [backgroundColor] is the background color of the snackbar's content container.
void showModernSnackBar({
  required BuildContext context,
  required String message,
  required final onPressed,
  IconData iconData = Icons.check_circle,
  Color iconColor = Colors.green,
  Color backgroundColor = Colors.white,
}) {
  // Hide any currently displayed snackbar
  ScaffoldMessenger.of(context).hideCurrentSnackBar();

  // Show the new snackbar
  final snackBar = SnackBar(
    content: Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(iconData, color: iconColor),
          const SizedBox(width: 12.0),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(color: Colors.black87, fontSize: 16.0),
            ),
          ),
        ],
      ),
    ),
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    elevation: 0,
    margin: const EdgeInsets.all(12.0),
    duration: const Duration(seconds: 2),
    action: SnackBarAction(label: 'Undo', onPressed: onPressed),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
