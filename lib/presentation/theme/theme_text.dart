import 'package:flutter/material.dart';
import 'package:seriestv_jobcity/presentation/theme/theme_color.dart';

class ThemeText {
  const ThemeText._();

  static TextStyle get _whiteHeadline6 => const TextStyle(
        fontSize: 20,
        color: Colors.white,
      );

  static TextStyle get _whiteHeadline5 => const TextStyle(
        fontSize: 24,
        color: Colors.white,
      );

  static TextStyle get _whiteSubtitle1 => const TextStyle(
        fontSize: 16,
        color: Colors.white,
      );

  static TextStyle get _whiteButton => const TextStyle(
        fontSize: 14,
        color: Colors.white,
      );

  static TextStyle get _whiteBodyText2 => const TextStyle(
        fontSize: 14,
        color: Colors.white,
        wordSpacing: 0.25,
        letterSpacing: 0.25,
        height: 1.5,
      );

  static getTextTheme() => TextTheme(
      headline5: _whiteHeadline5,
      headline6: _whiteHeadline6,
      bodyText2: _whiteBodyText2,
      subtitle1: _whiteSubtitle1,
      button: _whiteButton);
}

extension ThemeTextExtension on TextTheme {
  TextStyle get blueSubtitle1 =>
      subtitle1!.copyWith(color: AppColor.blue, fontWeight: FontWeight.w600);

  TextStyle get greySubtitle1 => subtitle1!.copyWith(
        color: AppColor.grey,
      );

  TextStyle get blueGreyHeadline6 => headline6!.copyWith(
        color: AppColor.blueGrey,
      );
  TextStyle get vulcanBodyText2 => bodyText2!.copyWith(
        color: AppColor.vulcan,
        // fontWeight: FontWeight.w600,
      );

  TextStyle get greyCaption => caption!.copyWith(
        color: Colors.grey,
      );
}
