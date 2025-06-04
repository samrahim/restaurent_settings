part of 'settings_bloc.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object?> get props => [];
}

class SettingsInitial extends SettingsState {
  const SettingsInitial();

  @override
  List<Object?> get props => [];
}

class SettingsLoaded extends SettingsState {
  final int selectedMainTab;
  final int selectedSubTab;
  final Map<String, Map<String, dynamic>> settings;

  const SettingsLoaded({
    required this.selectedMainTab,
    required this.selectedSubTab,
    required this.settings,
  });

  @override
  List<Object?> get props => [selectedMainTab, selectedSubTab, settings];

  SettingsLoaded copyWith({
    int? selectedMainTab,
    int? selectedSubTab,
    Map<String, Map<String, dynamic>>? settings,
  }) {
    return SettingsLoaded(
      selectedMainTab: selectedMainTab ?? this.selectedMainTab,
      selectedSubTab: selectedSubTab ?? this.selectedSubTab,
      settings: settings ?? this.settings,
    );
  }
}
