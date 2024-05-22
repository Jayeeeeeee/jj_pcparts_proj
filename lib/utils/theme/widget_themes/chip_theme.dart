import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class JJChipTheme {
  JJChipTheme._();

  static ChipThemeData lightChipTheme = ChipThemeData(
    disabledColor: JJColors.grey.withOpacity(0.4),
    labelStyle: const TextStyle(color: JJColors.black),
    selectedColor: JJColors.primary,
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
    checkmarkColor: JJColors.white,
  );

  static ChipThemeData darkChipTheme = const ChipThemeData(
    disabledColor: JJColors.darkerGrey,
    labelStyle: TextStyle(color: JJColors.white),
    selectedColor: JJColors.primary,
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
    checkmarkColor: JJColors.white,
  );
}
