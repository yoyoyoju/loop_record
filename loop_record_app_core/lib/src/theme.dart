import 'package:flutter/material.dart';

class LoopRecordTheme {
  static ThemeData get theme {
    final themeData = ThemeData.light();
    final textTheme = themeData.textTheme;

    return ThemeData.light().copyWith(
      primaryColor: Colors.pink,
    );
  }

  static ThemeData get dark {
    return ThemeData.dark().copyWith(
      primaryColor: Colors.blue,
    );
  }
}
