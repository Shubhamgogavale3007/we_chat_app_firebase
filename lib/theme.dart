import 'package:flutter/material.dart';

class changeTheme {
  /// Dark Theme
  ThemeData dark = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: Colors.white,
      primarySwatch: Colors.lightGreen,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          primary: Colors.black, // background (button) color
          onPrimary: Colors.white, // foreground (text) color
        ),
      ),
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: Colors.orange),
        bodyText2: TextStyle(color: Colors.white),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
      ));

  /// Light Theme
  ThemeData light = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: Colors.black,
      primarySwatch: Colors.orange,
      colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.orange),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.orange,
        iconTheme: IconThemeData(color: Colors.white),
      ));
}
