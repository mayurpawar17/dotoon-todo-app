import 'package:flutter/material.dart';

enum PriorityLevel { low, medium, high }

class PriorityProvider extends ChangeNotifier {
  PriorityLevel _selectedPriority = PriorityLevel.low;

  PriorityLevel get selectedPriority => _selectedPriority;

  PriorityLevel stringToPriority(String value) {
    switch (value) {
      case 'High':
        return PriorityLevel.high;
      case 'Medium':
        return PriorityLevel.medium;
      default:
        return PriorityLevel.low;
    }
  }

  String priorityToString(PriorityLevel level) {
    switch (level) {
      case PriorityLevel.high:
        return 'High';
      case PriorityLevel.medium:
        return 'Medium';
      case PriorityLevel.low:
        return 'Low';
    }
  }

  void updatePriority(PriorityLevel level) {
    _selectedPriority = level;
    notifyListeners();
  }
}
