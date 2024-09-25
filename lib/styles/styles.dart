import 'package:flutter/material.dart';

class Styles {
  static Color scaffoldBackgroundColor = Color(0xFFedc7b7);
  static Color defaultRedColor = const Color(0xffff698a);
  static Color defaultYellowColor = const Color(0xFFac3b61);
  static Color defaultBlueColor = const Color(0xff52beff);
  static Color defaultGreyColor = const Color(0xff77839a);
  static Color defaultLightGreyColor = const Color(0xffc4c4c4);
  static Color defaultLightWhiteColor = const Color(0xFFf2f6fe);
  static Color brandBackgroundColor = const Color(0xFF1C1C3A);
  static List<Color> brandGradientColor = [];
  static BoxDecoration brandingDecoration = BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Color(0xFF0F2027),
        Color(0xFF203A43),
        Color(0xFF2C5364),
        Colors.purple
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomRight,
    ),
  );

  static double defaultPadding = 18.0;

  static BorderRadius defaultBorderRadius = BorderRadius.circular(20);

  static ScrollbarThemeData scrollbarTheme =
      const ScrollbarThemeData().copyWith(
    thumbColor: MaterialStateProperty.all(defaultYellowColor),
    // isAlwaysShown: false,
    interactive: true,
  );
}
