import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../provider/priority_provider.dart';

class PrioritySelectorSheet extends StatelessWidget {
  const PrioritySelectorSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final priorityProvider = Provider.of<PriorityProvider>(
      context,
      listen: false,
    );
    final items = {
      PriorityLevel.low: 'Low',
      PriorityLevel.medium: 'Medium',
      PriorityLevel.high: 'High',
    };

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: items.entries.map((entry) {
          return ListTile(
            title: Text(
              entry.value,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            leading: Icon(
              EvaIcons.flagOutline,
              color: entry.key == PriorityLevel.high
                  ? Colors.red
                  : entry.key == PriorityLevel.medium
                  ? Colors.orange
                  : Colors.green,
            ),
            onTap: () {
              priorityProvider.updatePriority(entry.key);
              Navigator.pop(context);
              HapticFeedback.selectionClick();
            },
          );
        }).toList(),
      ),
    );
  }
}
