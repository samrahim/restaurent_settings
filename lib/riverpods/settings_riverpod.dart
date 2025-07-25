import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsState {
  final int selectedMainTab;
  final int selectedSubTab;
  final Map<String, Map<String, dynamic>> settings;

  const SettingsState({
    required this.selectedMainTab,
    required this.selectedSubTab,
    required this.settings,
  });

  SettingsState copyWith({
    int? selectedMainTab,
    int? selectedSubTab,
    Map<String, Map<String, dynamic>>? settings,
  }) {
    return SettingsState(
      selectedMainTab: selectedMainTab ?? this.selectedMainTab,
      selectedSubTab: selectedSubTab ?? this.selectedSubTab,
      settings: settings ?? this.settings,
    );
  }
}

class SettingsNotifier extends StateNotifier<SettingsState> {
  SettingsNotifier({required Map<String, Map<String, dynamic>> initialSettings})
    : super(
        SettingsState(
          selectedMainTab: 0,
          selectedSubTab: 0,
          settings: initialSettings,
        ),
      );

  void loadSettings() {
    state = state.copyWith(selectedMainTab: 0, selectedSubTab: 0);
  }

  void changeMainTab(int index) {
    state = state.copyWith(selectedMainTab: index, selectedSubTab: 0);
  }

  void changeSubTab(int mainIndex, int subIndex) {
    state = state.copyWith(
      selectedMainTab: mainIndex,
      selectedSubTab: subIndex,
    );
  }
}
