import 'package:flutter/material.dart';
import 'package:inter_intel_interview/app/utils/size_config.dart';
import 'package:inter_intel_interview/info/info.dart';

class DesignScreen extends StatelessWidget {
  const DesignScreen({Key? key, this.user}) : super(key: key);

  final User? user;

  static void route(BuildContext context, User user) {
    Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (context) => Scaffold(
            appBar: AppBar(
              elevation: 0,
              title: const Text('Profile'),
              centerTitle: true,
            ),
            body: SafeArea(
              child: DesignScreen(user: user),
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.width,
      child: Column(
        children: [
          ProfileImage(),
          Text(user?.firstName ?? ''),
        ],
      ),
    );
  }
}

class ProfileImage extends StatefulWidget {
  const ProfileImage({Key? key}) : super(key: key);

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
        AnimationController(vsync: this, duration: const Duration(seconds: 2));

    sizeAnimation = Tween(begin: 0.0, end: 1.0).animate(controller);
    colorAnimation =
        ColorTween(begin: Colors.green, end: Colors.purple).animate(controller);
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
        scale: sizeAnimation.value as double,
        child: Container(
            clipBehavior: Clip.antiAlias,
            height: SizeConfig.unitHeight * 15,
            decoration: const BoxDecoration(shape: BoxShape.circle),
            child: Image.network('https://thispersondoesnotexist.com/image')));
  }
}
