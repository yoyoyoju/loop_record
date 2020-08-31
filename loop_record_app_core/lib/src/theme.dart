import 'package:flutter/material.dart';

class LoopRecordTheme {
  static ThemeData get theme {
    final themeData = ThemeData.dark();
    final textTheme = themeData.textTheme;

    return ThemeData.dark().copyWith(
      primaryColor: Colors.pink,
    );
  }
}
