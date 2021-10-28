import 'package:flutter/material.dart';
import 'package:inter_intel_interview/app/utils/size_config.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: SizeConfig.height,
        width: SizeConfig.width,
        child: Column(),
      ),
    );
  }
}

class InfoForm extends StatelessWidget {
  const InfoForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
