import 'dart:ui';
import 'package:nischay_s_application2/core/app_export.dart';
import 'package:flutter/material.dart';

/// A class that offers pre-defined button styles for customizing button appearance.
class CustomButtonStyles {
  // Gradient button style
  static BoxDecoration get gradientIndigoACcToIndigoACcDecoration =>
      BoxDecoration(
        borderRadius: BorderRadius.circular(30.h),
        border: Border.all(
          color: appTheme.black900.withOpacity(0.1),
          width: 1.h,
        ),
        boxShadow: [
          BoxShadow(
            color: appTheme.indigoA20066,
            spreadRadius: 2.h,
            blurRadius: 40.h,
            offset: Offset(
              10,
              10,
            ),
          ),
        ],
        gradient: LinearGradient(
          begin: Alignment(0.5, 0),
          end: Alignment(0.5, 1),
          colors: [
            appTheme.whiteA700,
            appTheme.whiteA700
          ],
        ),
      );

  // Outline button style
  static ButtonStyle get outlineBlack => OutlinedButton.styleFrom(
        backgroundColor: appTheme.whiteA700,
        side: BorderSide(
          color: appTheme.black900.withOpacity(0.4),
          width:2,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2.h),
        ),
      );
  // text button style
  static ButtonStyle get none => ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
        elevation: MaterialStateProperty.all<double>(0),
      );
}
