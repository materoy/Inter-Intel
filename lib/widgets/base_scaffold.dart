import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inter_intel_interview/design/view/design_screen.dart';
import 'package:inter_intel_interview/dictionary/view/dictionary_screen.dart';
import 'package:inter_intel_interview/info/view/info_screen.dart';
import 'package:inter_intel_interview/response/view/response_screen.dart';
import 'package:inter_intel_interview/widgets/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:inter_intel_interview/widgets/bottom_nav_bar/cubit/bottom_nav_bar_cubit.dart';

class BaseScaffold extends StatelessWidget {
  const BaseScaffold({Key? key, this.body}) : super(key: key);

  final Widget? body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: body ??
            BlocBuilder<BottomNavBarCubit, BottomNavBarState>(
              builder: (context, state) {
                // Test to assert the new index is within bounds
                assert(state.screenIndex < screens().length);
                assert(state.screenIndex >= 0);

                return screens()[state.screenIndex];
              },
            ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }

  List<Widget> screens() {
    return const [
      InfoScreen(),
      DesignScreen(),
      ResponseScreen(),
      DictionaryScreen(),
    ];
  }
}
