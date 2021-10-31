// ignore_for_file: lines_longer_than_80_chars, prefer_int_literals

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
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
    return Column(
      children: [
        SizedBox(
          height: SizeConfig.unitHeight * 40,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: 0,
                child: Container(
                  alignment: Alignment.topCenter,
                  height: SizeConfig.unitHeight * 20,
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(20))),
                  child: Opacity(
                    opacity: .5,
                    child: Image.network(
                      // 'https://picsum.photos/seed/${Random().nextInt(1000)}/${(SizeConfig.width).toInt()}/${(SizeConfig.unitHeight * 20).toInt()}',
                      'https://picsum.photos/${(SizeConfig.width).toInt()}/${(SizeConfig.unitHeight * 20).toInt()}',
                      key: UniqueKey(),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: SizeConfig.unitHeight * 10,
                child: Column(
                  children: [
                    if (user == null)
                      const ProfileImage(
                          url: 'https://thispersondoesnotexist.com/image')
                    else
                      BlocBuilder<UserBloc, UserState>(
                        builder: (context, state) =>
                            ProfileImage(url: state.user.picture),
                      ),
                    SizedBox(
                      height: SizeConfig.unitHeight * 12,
                      child: BlocBuilder<UserBloc, UserState>(
                        builder: (context, state) {
                          return TweenAnimationBuilder<double>(
                              duration: const Duration(milliseconds: 1000),
                              tween: Tween(begin: 0.0, end: 1.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    '${user?.firstName ?? state.user.firstName}  ${user?.lastName ?? state.user.lastName}',
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                                  Text(user?.email ?? state.user.email,
                                      style: GoogleFonts.amiri(
                                          color: Colors.blue)),
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
                  ],
                ),
              ),
              Positioned(
                  top: SizeConfig.unitHeight * 30,
                  right: SizeConfig.unitWidth * 5,
                  child: IconButton(
                      onPressed: () {},
                      icon: const Icon(CupertinoIcons.settings)))
            ],
          ),
        ),
        const UserStats(),
        const Stories(),
      ],
    );
  }
}

class UserStats extends StatelessWidget {
  const UserStats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: SizeConfig.unitHeight * 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _statView('posts', 18),
          _statView('followers', 200),
          _statView('following', 800),
        ],
      ),
    );
  }

  Widget _statView(String title, int value) {
    return Column(
      children: [
        Text(
          value.toString(),
          style: GoogleFonts.robotoMono(color: Colors.purple),
        ),
        Text(
          title,
          style: GoogleFonts.robotoSlab(),
        ),
      ],
    );
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

class Stories extends StatefulWidget {
  const Stories({Key? key}) : super(key: key);

  @override
  _StoriesState createState() => _StoriesState();
}

class _StoriesState extends State<Stories> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Spacer(),
            Text(
              'stories',
              style:
                  GoogleFonts.play(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            const Spacer(flex: 10),
            Text('See All',
                style: GoogleFonts.robotoCondensed(color: Colors.blue)),
            const Icon(CupertinoIcons.chevron_right),
            const Spacer(),
          ],
        ),
        SizedBox(
          height: SizeConfig.unitHeight * 30,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 4,
            padding: const EdgeInsets.only(left: 20),
            itemBuilder: (context, index) {
              return Container(
                clipBehavior: Clip.antiAlias,
                margin: EdgeInsets.symmetric(
                    horizontal: SizeConfig.unitWidth * 3,
                    vertical: SizeConfig.unitHeight * 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TweenAnimationBuilder<double>(
                    duration: const Duration(seconds: 2),
                    tween: Tween(begin: 0.0, end: 1.0),
                    child: Image.network(
                      'https://picsum.photos/seed/${Random().nextInt(1000)}/${(SizeConfig.unitWidth * 45).toInt()}/${(SizeConfig.unitHeight * 27).toInt()}',
                      key: UniqueKey(),
                    ),
                    builder: (context, animation, child) {
                      return Opacity(opacity: animation, child: child);
                    }),
              );
            },
          ),
        )
      ],
    );
  }
}
