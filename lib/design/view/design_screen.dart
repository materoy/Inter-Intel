// ignore_for_file: lines_longer_than_80_chars, prefer_int_literals

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inter_intel_interview/app/utils/size_config.dart';
import 'package:inter_intel_interview/design/bloc/user_bloc.dart';
import 'package:inter_intel_interview/info/info.dart';

class DesignScreen extends StatelessWidget {
  const DesignScreen({Key? key, this.user}) : super(key: key);

  final User? user;

  static void route(BuildContext context, User user) {
    Navigator.push(
        context,
        PageRouteBuilder<void>(
            pageBuilder: (context, animation, secondaryAnimation) {
              return Scaffold(
                  appBar: AppBar(
                    elevation: 0,
                    title: const Text('Profile'),
                    centerTitle: true,
                  ),
                  body: SafeArea(
                    child: DesignScreen(user: user),
                  ));
            },
            transitionDuration: const Duration(milliseconds: 1000),
            fullscreenDialog: true,
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return AnimatedScale(
                duration: const Duration(milliseconds: 500),
                scale: animation.value,
                curve: Curves.easeInOut,
                child: AnimatedOpacity(
                  duration: const Duration(seconds: 2),
                  // opacity: animation.value,
                  opacity: 1,
                  child: child,
                ),
              );
            },
            reverseTransitionDuration: const Duration(seconds: 1)));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserBloc>(
      create: (context) => UserBloc()..add(UserLoaded()),
      child: DesignView(user: user),
    );
  }
}

class DesignView extends StatelessWidget {
  const DesignView({Key? key, this.user}) : super(key: key);
  final User? user;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: SizeConfig.width,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.unitWidth * 5,
                  vertical: SizeConfig.unitHeight * 2),
              child: Row(
                children: [
                  if (user == null)
                    const ProfileImage(
                        url: 'https://thispersondoesnotexist.com/image')
                  else
                    BlocBuilder<UserBloc, UserState>(
                      builder: (context, state) =>
                          ProfileImage(url: state.user.picture),
                    ),
                  const Spacer(),
                  SizedBox(
                    height: SizeConfig.unitHeight * 18,
                    child: BlocBuilder<UserBloc, UserState>(
                      builder: (context, state) {
                        return TweenAnimationBuilder<double>(
                            duration: const Duration(milliseconds: 1000),
                            tween: Tween(begin: 0.0, end: 1.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${user?.firstName ?? state.user.firstName}  ${user?.lastName ?? state.user.lastName}',
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                                Text(user?.email ?? state.user.email),
                                Text(user?.phoneNumber ??
                                    state.user.phoneNumber),
                              ],
                            ),
                            builder: (context, animation, child) {
                              return Opacity(
                                opacity: animation,
                                child: child,
                              );
                            });
                      },
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
            const UserActivity(),
          ],
        ));
  }
}

class ProfileImage extends StatefulWidget {
  const ProfileImage({Key? key, required this.url}) : super(key: key);

  final String url;

  @override
  _ProfileImageState createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage>
    with TickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation sizeAnimation;
  late final Animation colorAnimation;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    sizeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(controller);

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.0, end: 1.0),
        duration: const Duration(milliseconds: 500),
        child: Container(
          clipBehavior: Clip.hardEdge,
          height: SizeConfig.unitHeight * 18,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Image.network(
            widget.url,
            fit: BoxFit.cover,
          ),
        ),
        builder: (context, animation, child) {
          return AnimatedOpacity(
              opacity: animation,
              duration: const Duration(seconds: 1),
              child: child);
        });
  }
}

class UserActivity extends StatefulWidget {
  const UserActivity({Key? key}) : super(key: key);

  @override
  _UserActivityState createState() => _UserActivityState();
}

class _UserActivityState extends State<UserActivity> {
  late int index;
  @override
  void initState() {
    super.initState();
    index = 0;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoSegmentedControl(
      children: {
        0: segmentedControll('Posts'),
        1: segmentedControll('Followers'),
        2: segmentedControll('Following'),
      },
      groupValue: index,
      padding: EdgeInsets.symmetric(vertical: SizeConfig.unitHeight * 2),
      onValueChanged: (value) => setState(() {
        index = value! as int;
      }),
    );
  }

  Widget segmentedControll(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.unitWidth * 5,
          vertical: SizeConfig.unitHeight * 1.5),
      child: Text(text),
    );
  }
}
