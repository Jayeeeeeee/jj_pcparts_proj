import 'package:flutter/material.dart';
import 'package:jj_pcparts_proj/utils/constants/colors.dart';
import '../../constants/sizes.dart';

class JJTextFormFieldTheme {
  JJTextFormFieldTheme._();

  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: JJColors.darkGrey,
    suffixIconColor: JJColors.darkGrey,
    // constraints: const BoxConstraints.expand(height: JJSizes.inputFieldHeight),
    labelStyle: const TextStyle()
        .copyWith(fontSize: JJSizes.fontSizeMd, color: JJColors.black),
    hintStyle: const TextStyle()
        .copyWith(fontSize: JJSizes.fontSizeSm, color: JJColors.black),
    errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal),
    floatingLabelStyle:
        const TextStyle().copyWith(color: JJColors.black.withOpacity(0.8)),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(JJSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: JJColors.grey),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(JJSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: JJColors.grey),
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(JJSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: JJColors.dark),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(JJSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: JJColors.warning),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(JJSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 2, color: JJColors.warning),
    ),
  );

  static InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 2,
    prefixIconColor: JJColors.darkGrey,
    suffixIconColor: JJColors.darkGrey,
    // constraints: const BoxConstraints.expand(height: JJSizes.inputFieldHeight),
    labelStyle: const TextStyle()
        .copyWith(fontSize: JJSizes.fontSizeMd, color: JJColors.white),
    hintStyle: const TextStyle()
        .copyWith(fontSize: JJSizes.fontSizeSm, color: JJColors.white),
    floatingLabelStyle:
        const TextStyle().copyWith(color: JJColors.white.withOpacity(0.8)),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(JJSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: JJColors.darkGrey),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(JJSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: JJColors.darkGrey),
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(JJSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: JJColors.white),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(JJSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: JJColors.warning),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(JJSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 2, color: JJColors.warning),
    ),
  );
}
