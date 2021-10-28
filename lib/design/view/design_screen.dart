import 'package:flutter/material.dart';
import 'package:inter_intel_interview/info/info.dart';

class DesignScreen extends StatelessWidget {
  const DesignScreen({Key? key, this.user}) : super(key: key);

  final User? user;

  static void route(BuildContext context, User user) {
    Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (context) => DesignScreen(user: user),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(user?.firstName ?? ''),
      ],
    );
  }
}
