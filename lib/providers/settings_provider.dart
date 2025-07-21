import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier {
  int _selectedMainTab = 0;
  int _selectedSubTab = 0;
  final Map<String, Map<String, dynamic>> _settings;

  SettingsProvider({required Map<String, Map<String, dynamic>> initialSettings})
    : _settings = initialSettings;

  int get selectedMainTab => _selectedMainTab;
  int get selectedSubTab => _selectedSubTab;
  Map<String, Map<String, dynamic>> get settings => _settings;

  void loadSettings() {
    _selectedMainTab = 0;
    _selectedSubTab = 0;
    notifyListeners();
  }

  void changeMainTab(int index) {
    _selectedMainTab = index;
    _selectedSubTab = 0;
    notifyListeners();
  }

  void changeSubTab(int mainIndex, int subIndex) {
    _selectedMainTab = mainIndex;
    _selectedSubTab = subIndex;
    notifyListeners();
  }
}
