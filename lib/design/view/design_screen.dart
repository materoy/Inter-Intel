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
              title: Text('${user.firstName} ${user.lastName}'),
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
          Text(user?.firstName ?? ''),
        ],
      ),
    );
  }
}
