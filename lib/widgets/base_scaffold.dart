import 'dart:developer';

import 'package:flutter/cupertino.dart';
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
      appBar: AppBar(
        elevation: 0,
        title: BlocBuilder<BottomNavBarCubit, BottomNavBarState>(
          builder: (context, state) {
            return Text(state.title);
          },
        ),
        centerTitle: true,
        leading: BlocBuilder<BottomNavBarCubit, BottomNavBarState>(
          builder: (context, state) {
            /// Shows the back navigation button on the action bar
            /// only when there is a back stack to navigate and not on homepage
            if (state.backStack.isNotEmpty && state.screenIndex != 0) {
              return IconButton(
                icon: const Icon(CupertinoIcons.chevron_back),
                onPressed: () {
                  context.read<BottomNavBarCubit>().navigateToScreenIndex(
                      state.backStack.last.screenIndex,
                      state.backStack.removeLast().title);
                },
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
      body: SafeArea(
        child: body ??
            BlocBuilder<BottomNavBarCubit, BottomNavBarState>(
              builder: (context, state) {
                // Test to assert the new index is within bounds
                assert(state.screenIndex < screens().length);
                assert(state.screenIndex >= 0);

                return AnimatedScreen(body: screens()[state.screenIndex]);
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

class AnimatedScreen extends StatefulWidget {
  const AnimatedScreen({Key? key, required this.body}) : super(key: key);

  final Widget body;

  @override
  _AnimatedScreenState createState() => _AnimatedScreenState();
}

class _AnimatedScreenState extends State<AnimatedScreen>
    with TickerProviderStateMixin {
  late final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(seconds: 1),
      opacity: 1,
      child: widget.body,
    );
  }
}
