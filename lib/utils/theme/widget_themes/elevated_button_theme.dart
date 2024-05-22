import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../constants/sizes.dart';

/* -- Light & Dark Elevated Button Themes -- */
class JJElevatedButtonTheme {
  JJElevatedButtonTheme._(); //To avoid creating instances

  /* -- Light Theme -- */
  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: JJColors.light,
      backgroundColor: JJColors.primary,
      disabledForegroundColor: JJColors.darkGrey,
      disabledBackgroundColor: JJColors.buttonDisabled,
      side: const BorderSide(color: JJColors.primary),
      padding: const EdgeInsets.symmetric(vertical: JJSizes.buttonHeight),
      textStyle: const TextStyle(
          fontSize: 16, color: JJColors.textWhite, fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(JJSizes.buttonRadius)),
    ),
  );

  /* -- Dark Theme -- */
  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: JJColors.light,
      backgroundColor: JJColors.primary,
      disabledForegroundColor: JJColors.darkGrey,
      disabledBackgroundColor: JJColors.darkerGrey,
      side: const BorderSide(color: JJColors.primary),
      padding: const EdgeInsets.symmetric(vertical: JJSizes.buttonHeight),
      textStyle: const TextStyle(
          fontSize: 16, color: JJColors.textWhite, fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(JJSizes.buttonRadius)),
    ),
  );
}
