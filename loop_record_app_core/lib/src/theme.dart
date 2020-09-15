import 'package:flutter/material.dart';

class LoopRecordTheme {
  static const String fontDefault = 'Times new Roman';

  static const Color _lightPink = Color(0xffffd9d9);
  static const Color _rosepink = Color(0xffe3a7a7);
  static const Color _darkred = Color(0xff751d1d);

  static const Color _darkBlue = Color(0xff2c2a44);
  static const Color _darkerBlue = Color(0xff191637);

  static const Color _lightPrimaryColor = _rosepink;
  static const Color _lightPrimaryVariantColor = _lightPink;
  static const Color _lightOnPrimaryColor = Colors.black;
  static const Color _lightPrimaryAccentColor = _darkred;
  static const Color _lightSecondaryColor =
      Colors.black; // For shapes and buttons colors

  static const Color _darkPrimaryColor = _darkBlue;
  static const Color _darkPrimaryVariantColor = _darkerBlue;
  static const Color _darkOnPrimaryColor = Colors.white;
  static const Color _darkPrimaryAccentColor = Colors.black;
  static const Color _darkSecondaryColor = Colors.black;

  // Normal Theme
  static ThemeData get theme {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: _lightPrimaryVariantColor,
      primaryColor: _lightPrimaryColor,
      accentColor: _lightPrimaryAccentColor,
      fontFamily: fontDefault,
      appBarTheme: AppBarTheme(
        color: _lightPrimaryColor,
        iconTheme: IconThemeData(color: _lightOnPrimaryColor),
        elevation: 0.0,
      ),
      colorScheme: ColorScheme.light(
        primary: _lightPrimaryColor,
        primaryVariant: _lightPrimaryVariantColor,
        secondary: _lightSecondaryColor,
        onPrimary: _lightOnPrimaryColor,
      ),
    );

    /*
    ThemeData.light().copyWith(
      primaryColor: Colors.pink,
    );
    */
  }

  // DarkTheme
  static ThemeData get dark {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: _darkPrimaryVariantColor,
      primaryColor: _darkPrimaryColor,
      accentColor: _darkPrimaryAccentColor,
      fontFamily: fontDefault,
      appBarTheme: AppBarTheme(
        elevation: 0.0,
      ),
    );
    /*
           ThemeData.dark().copyWith(
      primaryColor: Colors.blue,
    );
    */
  }
}
