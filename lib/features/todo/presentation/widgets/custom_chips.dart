import 'package:flutter/material.dart';

class CustomChips extends StatelessWidget {
  final VoidCallback? onTap;
  final String text;
  final bool selected;

  const CustomChips({
    super.key,
    this.onTap,
    required this.text,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final Color selectedBg = isDark
        ? Colors.lightBlueAccent.withOpacity(0.25)
        : Colors.lightBlue.withOpacity(0.15);

    final Color selectedText = isDark
        ? Colors.lightBlueAccent
        : Colors.lightBlue;
    final Color unselectedText = isDark ? Colors.white70 : Colors.black87;
    final Color borderColor = selected
        ? selectedText
        : (isDark ? Colors.white24 : Colors.black26);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: borderColor),
          color: selected ? selectedBg : Colors.transparent,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: selected ? selectedText : unselectedText,
          ),
        ),
      ),
    );
  }
}
