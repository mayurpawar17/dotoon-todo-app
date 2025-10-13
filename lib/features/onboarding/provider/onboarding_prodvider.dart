import 'package:flutter/widgets.dart';

import '../data/onboarding_services.dart';

class OnBoardingProvider extends ChangeNotifier {
  final OnBoardingServices _onBoardingServices = OnBoardingServices();
  String _name = '';

  String get name => _name;

  void setName(String newName) {
    _name = newName;
    _name = capitalize(_name);
    _onBoardingServices.saveName(_name);
    notifyListeners();
  }

  String capitalize(String text) {
    if (text.isEmpty) return '';
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }
}
