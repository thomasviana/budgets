part of 'main_screen_cubit.dart';

class MainScreenState {
  final int? selectedPageIndex;
  final bool homeSelected;
  final bool statsSelected;
  final bool recordsSelected;
  final bool settingSelected;
  MainScreenState({
    this.selectedPageIndex,
    required this.homeSelected,
    required this.statsSelected,
    required this.recordsSelected,
    required this.settingSelected,
  });

  factory MainScreenState.initial() => MainScreenState(
        homeSelected: true,
        statsSelected: false,
        recordsSelected: false,
        settingSelected: false,
      );

  MainScreenState copyWith({
    int? selectedPageIndex,
    bool? homeSelected,
    bool? statsSelected,
    bool? recordsSelected,
    bool? settingSelected,
  }) {
    return MainScreenState(
      selectedPageIndex: selectedPageIndex ?? this.selectedPageIndex,
      homeSelected: homeSelected ?? this.homeSelected,
      statsSelected: statsSelected ?? this.statsSelected,
      recordsSelected: recordsSelected ?? this.recordsSelected,
      settingSelected: settingSelected ?? this.settingSelected,
    );
  }
}
