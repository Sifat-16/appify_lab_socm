import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Palette {
  // Colors
  static const blackColor = Color.fromRGBO(1, 1, 1, 1); // primary color
  static const greyColor = Color.fromRGBO(26, 39, 45, 1); // secondary color
  static const drawerColor = Color.fromRGBO(18, 18, 18, 1);
  static const whiteColor = Colors.white;
  static var redColor = Colors.red.shade500;
  static var blueColor = const Color.fromRGBO(59,89,152, 1);
  static var paleBlueColor = const Color.fromRGBO(139,157,195, 1);
  static var lightBlueColor = const Color.fromRGBO(223,227,238, 1);
  static var lightAccentBlueColor = const Color.fromRGBO(247,247,247, 1);
  static const Color online = Color(0xFF4BCB1F);
  static const darkGreyColor = Color.fromARGB(255, 159, 159, 159);

  // Themes
  static var darkModeAppTheme = ThemeData(
    scaffoldBackgroundColor: blackColor,
    brightness: Brightness.dark,
    fontFamily: 'Roboto',
    cardColor: greyColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: drawerColor,
      iconTheme: IconThemeData(
        color: whiteColor,
      ),
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: drawerColor,
    ),
    primaryColor: redColor,
    backgroundColor: drawerColor, // will be used as alternative background color
  );



  static var lightModeAppTheme = ThemeData(
    brightness: Brightness.light,
    fontFamily: 'Roboto',
    scaffoldBackgroundColor: lightAccentBlueColor,
    cardColor: whiteColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: whiteColor,
      elevation: 0,
      iconTheme: IconThemeData(
        color: blackColor,
      ),
    ),

    drawerTheme: const DrawerThemeData(
      backgroundColor: whiteColor,
    ),
    primaryColor: redColor,
    backgroundColor: whiteColor,
  );

  static const LinearGradient storyGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Colors.transparent, Colors.black26],
  );
}

