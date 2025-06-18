import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class AppTheme {
  // Colors
  static const Color primaryColor = Color(0xFF007AFF);
  static const Color secondaryColor = Color(0xFF5856D6);
  static const Color backgroundColor = Color(0xFFF2F2F7);
  static const Color surfaceColor = Colors.white;
  static const Color errorColor = Color(0xFFFF3B30);
  static const Color successColor = Color(0xFF34C759);
  static const Color warningColor = Color(0xFFFF9500);
  static const Color textColor = Color(0xFF000000);
  static const Color textSecondaryColor = Color(0xFF8E8E93);
  static const Color dividerColor = Color(0xFFC6C6C8);

  // Text styles
  static const TextStyle heading1 = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: textColor,
  );

  static const TextStyle heading2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: textColor,
  );

  static const TextStyle heading3 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: textColor,
  );

  static const TextStyle body1 = TextStyle(
    fontSize: 16,
    color: textColor,
  );

  static const TextStyle body2 = TextStyle(
    fontSize: 14,
    color: textColor,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 12,
    color: textSecondaryColor,
  );

  // Button styles
  static ButtonStyle primaryButtonStyle = ButtonStyle(
    backgroundColor: WidgetStateProperty.all(primaryColor),
    foregroundColor: WidgetStateProperty.all(Colors.white),
    padding: WidgetStateProperty.all(
      const EdgeInsets.symmetric(
        horizontal: AppConstants.defaultPadding,
        vertical: AppConstants.smallPadding,
      ),
    ),
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
      ),
    ),
  );

  static ButtonStyle secondaryButtonStyle = ButtonStyle(
    backgroundColor: WidgetStateProperty.all(Colors.white),
    foregroundColor: WidgetStateProperty.all(primaryColor),
    padding: WidgetStateProperty.all(
      const EdgeInsets.symmetric(
        horizontal: AppConstants.defaultPadding,
        vertical: AppConstants.smallPadding,
      ),
    ),
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
        side: const BorderSide(color: primaryColor),
      ),
    ),
  );

  // Card style
  static BoxDecoration cardDecoration = BoxDecoration(
    color: surfaceColor,
    borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 8,
        offset: const Offset(0, 2),
      ),
    ],
  );

  // Input decoration
  static InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
    filled: true,
    fillColor: surfaceColor,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
      borderSide: BorderSide.none,
    ),
    contentPadding: const EdgeInsets.all(AppConstants.defaultPadding),
  );

  // Cupertino theme
  static CupertinoThemeData cupertinoTheme = const CupertinoThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColor,
    textTheme: CupertinoTextThemeData(
      primaryColor: textColor,
      textStyle: body1,
      navTitleTextStyle: heading2,
      navLargeTitleTextStyle: heading1,
    ),
  );

  // Material theme
  static ThemeData materialTheme = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColor,
    colorScheme: const ColorScheme.light(
      primary: primaryColor,
      secondary: secondaryColor,
      surface: surfaceColor,
      error: errorColor,
    ),
    textTheme: const TextTheme(
      displayLarge: heading1,
      displayMedium: heading2,
      displaySmall: heading3,
      bodyLarge: body1,
      bodyMedium: body2,
      bodySmall: caption,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: primaryButtonStyle,
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: secondaryButtonStyle,
    ),
    inputDecorationTheme: inputDecorationTheme,
  );
}
