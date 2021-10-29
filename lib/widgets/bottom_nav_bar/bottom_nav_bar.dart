import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inter_intel_interview/app/utils/size_config.dart';
import 'package:inter_intel_interview/widgets/bottom_nav_bar/cubit/bottom_nav_bar_cubit.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavBarCubit, BottomNavBarState>(
      builder: (context, state) {
        return CurvedNavigationBar(
          items: widgetItems(),
          index: state.screenIndex,
          height: SizeConfig.unitHeight * 6,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          color: Theme.of(context).bottomNavigationBarTheme.backgroundColor!,

          /// Navigates to given screen and adds it's state to the back stack
          onTap: (value) {
            if (value != state.screenIndex) {
              context.read<BottomNavBarCubit>().navigateToScreenIndex(
                  value, items()[value].label!,
                  backStack: state.backStack..add(state));
            }
          },
        );
      },
    );
  }

  List<Widget> widgetItems() {
    return const [
      Icon(Icons.info_outline),
      Icon(CupertinoIcons.person_alt_circle),
      Icon(CupertinoIcons.text_badge_checkmark),
      Icon(CupertinoIcons.sort_down_circle),
    ];
  }

  List<BottomNavigationBarItem> items() {
    return const [
      BottomNavigationBarItem(icon: Icon(Icons.info_outline), label: 'Info'),
      BottomNavigationBarItem(
          icon: Icon(Icons.design_services_rounded), label: 'Design'),
      BottomNavigationBarItem(
          icon: Icon(Icons.request_page_outlined), label: 'Response'),
      BottomNavigationBarItem(
          icon: Icon(Icons.data_usage), label: 'Dictionary'),
    ];
  }
}
