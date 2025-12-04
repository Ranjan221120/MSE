import 'package:flutter/material.dart';

class AppTheme {
  static final lightTheme = Theme(
    data: ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.blue,
      useMaterial3: true,
      cardTheme: CardThemeData(
        surfaceTintColor: Colors.transparent,
      ),elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          elevation: 4.0,
        ),
      ),
    ),
    child: Container(),
  );

  static final darkTheme = Theme(
    data: ThemeData(
      brightness: Brightness.dark,
      primarySwatch: Colors.blue,
      useMaterial3: true,
      cardTheme: CardThemeData(
        color: Colors.grey[750],
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.white24,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          surfaceTintColor: Colors.transparent,
          shadowColor: Colors.white24,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          elevation: 4.0,
        ),
      ),
    ),
    child: Container(),
  );
}