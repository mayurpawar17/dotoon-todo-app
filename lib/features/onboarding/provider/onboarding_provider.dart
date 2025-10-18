import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../data/onboarding_services.dart';

class OnBoardingProvider extends ChangeNotifier {
  final OnBoardingServices _onBoardingServices = OnBoardingServices();
  String _name = '';

  String get name => _name;
  final TextEditingController nameController = TextEditingController();

  //Load name when app starts or when needed
  Future<void> loadName() async {
    final savedName = await _onBoardingServices.loadName();
    if (savedName != null && savedName.isNotEmpty && savedName != 'null') {
      _name = savedName;
      notifyListeners();
    }
  }

  void setName(String newName) {
    _name = capitalize(newName);
    _onBoardingServices.saveName(_name);
    notifyListeners();
  }

  String capitalize(String text) {
    if (text.isEmpty) return '';
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  void loadPreviousName() {
    nameController.text = _name; // show old name in textfield
    _onBoardingServices.saveName(_name);
    notifyListeners();
  }

  void clearEditing() {
    nameController.clear();
    HapticFeedback.selectionClick();
    notifyListeners();
  }
}
