import 'package:flutter/material.dart';
import 'package:jj_pcparts_proj/utils/theme/widget_themes/appbar_theme.dart';
import 'package:jj_pcparts_proj/utils/theme/widget_themes/bottom_sheet_theme.dart';
import 'package:jj_pcparts_proj/utils/theme/widget_themes/checkbox_theme.dart';
import 'package:jj_pcparts_proj/utils/theme/widget_themes/chip_theme.dart';
import 'package:jj_pcparts_proj/utils/theme/widget_themes/elevated_button_theme.dart';
import 'package:jj_pcparts_proj/utils/theme/widget_themes/outlined_button_theme.dart';
import 'package:jj_pcparts_proj/utils/theme/widget_themes/text_field_theme.dart';
import 'package:jj_pcparts_proj/utils/theme/widget_themes/text_theme.dart';

import '../constants/colors.dart';

class JJAppTheme {
  JJAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    disabledColor: JJColors.grey,
    brightness: Brightness.light,
    primaryColor: JJColors.primary,
    textTheme: JJTextTheme.lightTextTheme,
    chipTheme: JJChipTheme.lightChipTheme,
    scaffoldBackgroundColor: JJColors.white,
    appBarTheme: JJAppBarTheme.lightAppBarTheme,
    checkboxTheme: JJCheckboxTheme.lightCheckboxTheme,
    bottomSheetTheme: JJBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: JJElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: JJOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: JJTextFormFieldTheme.lightInputDecorationTheme,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    disabledColor: JJColors.grey,
    brightness: Brightness.dark,
    primaryColor: JJColors.primary,
    textTheme: JJTextTheme.darkTextTheme,
    chipTheme: JJChipTheme.darkChipTheme,
    scaffoldBackgroundColor: JJColors.black,
    appBarTheme: JJAppBarTheme.darkAppBarTheme,
    checkboxTheme: JJCheckboxTheme.darkCheckboxTheme,
    bottomSheetTheme: JJBottomSheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: JJElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: JJOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: JJTextFormFieldTheme.darkInputDecorationTheme,
  );
}
