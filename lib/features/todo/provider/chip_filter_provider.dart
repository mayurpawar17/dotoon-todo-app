import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

enum TodoFilter { all, pending, completed }

class ChipFilterProvider extends ChangeNotifier {
  late TodoFilter _selectedFilter = TodoFilter.all;

  TodoFilter get selectedFilter => _selectedFilter;
  final List<Map<String, dynamic>> chipOptions = [
    {'label': 'All', 'filter': TodoFilter.all},
    {'label': 'Pending', 'filter': TodoFilter.pending},
    {'label': 'Completed', 'filter': TodoFilter.completed},
  ];

  // ACTION: This is the method the UI will call to change the state.
  void updateFilter(TodoFilter filter) {
    _selectedFilter = filter;
    // This is the most important line! It tells all listening widgets to rebuild.
    HapticFeedback.selectionClick();
    notifyListeners();
  }
}
