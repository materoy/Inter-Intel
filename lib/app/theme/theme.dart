import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inter_intel_interview/app/theme/colors.dart';

final lightTheme = ThemeData(
    primaryColor: bluishGreen,
    scaffoldBackgroundColor: white,
    cardColor: whiteBackground,
    appBarTheme: const AppBarTheme(
        backgroundColor: whiteBackground,
        systemOverlayStyle: SystemUiOverlayStyle(),
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        )),
    iconTheme: const IconThemeData(color: bluishGreen),
    primaryIconTheme: const IconThemeData(color: bluishGreen),
    bottomAppBarTheme: const BottomAppBarTheme(color: white),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: whiteBackground,
      selectedIconTheme: IconThemeData(color: bluishGreen),
    ));

final darkTheme = ThemeData.dark().copyWith(primaryColor: liveGreenDark);
