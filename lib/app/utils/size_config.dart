import 'package:flutter/widgets.dart';

class SizeConfig {
  static late MediaQueryData mediaQueryData;
  void initialize(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
  }

  static double unitHeight = mediaQueryData.size.height / 100;
  static double unitWidth = mediaQueryData.size.width / 100;

  static double height = mediaQueryData.size.height;
  static double width = mediaQueryData.size.width;

  static double safeWidth = width - mediaQueryData.viewPadding.horizontal;
  static double safeHeight = height - mediaQueryData.viewPadding.vertical;
  static late double topPadding = mediaQueryData.padding.top;
  static double? bottomPadding = mediaQueryData.padding.bottom;
}
