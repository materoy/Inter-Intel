part of 'bottom_nav_bar_cubit.dart';

@immutable
class BottomNavBarState {
  const BottomNavBarState(this.screenIndex, this.title, this.backStack);

  final int screenIndex;
  final String title;

  final List<BottomNavBarState> backStack;

  void copyWith() {}
}
