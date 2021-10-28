import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inter_intel_interview/widgets/bottom_nav_bar/cubit/bottom_nav_bar_cubit.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavBarCubit, BottomNavBarState>(
      builder: (context, state) {
        return BottomNavigationBar(
          items: items(),
          currentIndex: state.screenIndex,
          onTap: (value) => context
              .read<BottomNavBarCubit>()
              .navigateToScreenIndex(value, items()[value].label!),
        );
      },
    );
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
