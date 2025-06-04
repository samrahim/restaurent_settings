part of 'settings_bloc.dart';

sealed class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object?> get props => [];
}

class LoadSettings extends SettingsEvent {
  const LoadSettings();

  @override
  List<Object?> get props => [];
}

class ChangeMainTab extends SettingsEvent {
  final int index;
  const ChangeMainTab(this.index);

  @override
  List<Object?> get props => [index];
}

class ChangeSubTab extends SettingsEvent {
  final int mainIndex;
  final int subIndex;
  const ChangeSubTab(this.mainIndex, this.subIndex);

  @override
  List<Object?> get props => [mainIndex, subIndex];
}
