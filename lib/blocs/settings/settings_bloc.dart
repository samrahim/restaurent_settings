import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final Map<String, Map<String, dynamic>> initialSettings;

  SettingsBloc({required this.initialSettings})
    : super(const SettingsInitial()) {
    on<LoadSettings>(_onLoadSettings);
    on<ChangeMainTab>(_onChangeMainTab);
    on<ChangeSubTab>(_onChangeSubTab);
  }

  void _onLoadSettings(LoadSettings event, Emitter<SettingsState> emit) {
    emit(
      SettingsLoaded(
        selectedMainTab: 0,
        selectedSubTab: 0,
        settings: initialSettings,
      ),
    );
  }

  void _onChangeMainTab(ChangeMainTab event, Emitter<SettingsState> emit) {
    if (state is SettingsLoaded) {
      final currentState = state as SettingsLoaded;
      emit(
        currentState.copyWith(selectedMainTab: event.index, selectedSubTab: 0),
      );
    }
  }

  void _onChangeSubTab(ChangeSubTab event, Emitter<SettingsState> emit) {
    if (state is SettingsLoaded) {
      final currentState = state as SettingsLoaded;
      emit(
        currentState.copyWith(
          selectedMainTab: event.mainIndex,
          selectedSubTab: event.subIndex,
        ),
      );
    }
  }
}
