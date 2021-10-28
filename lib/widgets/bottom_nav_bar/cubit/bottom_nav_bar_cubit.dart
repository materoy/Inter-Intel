import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'bottom_nav_bar_state.dart';

class BottomNavBarCubit extends Cubit<BottomNavBarState> {
  BottomNavBarCubit()
      : super(BottomNavBarState(
            0, 'Info', List<BottomNavBarState>.empty(growable: true)));

  void navigateToScreenIndex(int index, String title) {
    // Add current state to the back stack for back navigation
    final backStack = state.backStack..add(state);
    emit(BottomNavBarState(index, title, backStack));
  }
}
