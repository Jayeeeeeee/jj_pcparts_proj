import 'package:flutter/material.dart';
import 'package:jj_pcparts_proj/utils/constants/sizes.dart';
import '../../constants/colors.dart';

class JJAppBarTheme {
  JJAppBarTheme._();

  static const lightAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(color: JJColors.black, size: JJSizes.iconMd),
    actionsIconTheme:
        IconThemeData(color: JJColors.black, size: JJSizes.iconMd),
    titleTextStyle: TextStyle(
        fontSize: 18.0, fontWeight: FontWeight.w600, color: JJColors.black),
  );
  //
  static const darkAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(color: JJColors.black, size: JJSizes.iconMd),
    actionsIconTheme:
        IconThemeData(color: JJColors.white, size: JJSizes.iconMd),
    titleTextStyle: TextStyle(
        fontSize: 18.0, fontWeight: FontWeight.w600, color: JJColors.white),
  );
}
