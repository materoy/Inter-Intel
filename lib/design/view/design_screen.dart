import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inter_intel_interview/app/utils/size_config.dart';
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
            transitionDuration: const Duration(milliseconds: 1500),
            fullscreenDialog: true,
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return AnimatedScale(
                duration: const Duration(milliseconds: 1000),
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
                const ProfileImage(),
                const Spacer(),
                SizedBox(
                  height: SizeConfig.unitHeight * 18,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${user?.firstName}  ${user?.lastName}',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Text('${user?.email}'),
                      Text('${user?.phoneNumber}'),
                    ],
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
          UserActivity(),
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
        scale: 1,
        child: Container(
          clipBehavior: Clip.antiAlias,
          height: SizeConfig.unitHeight * 18,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Theme.of(context).primaryColor,
              width: 3,
            ),
          ),
          child: Image.network(
            'https://thispersondoesnotexist.com/image',
            fit: BoxFit.cover,
          ),
        ));
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
    return Container(
        child: CupertinoSegmentedControl(
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
    ));
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
