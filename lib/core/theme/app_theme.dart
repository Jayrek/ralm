import 'package:flutter/material.dart';
import 'package:ralm/core/constants/string_constant.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    useMaterial3: true,
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontFamily: StringConstant.fontWhisper,
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      titleMedium: TextStyle(
        fontFamily: StringConstant.fontTinos,
        fontSize: 20,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
      bodyMedium: TextStyle(
        fontFamily: StringConstant.fontTinos,
        fontSize: 16,
        color: Colors.white,
      ),
      bodySmall: TextStyle(
        fontFamily: StringConstant.fontTinos,
        fontSize: 14,
        color: Colors.white,
      ),
    ),
  );
}
