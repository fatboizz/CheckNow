import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// Legacy color export aliases for backward compatibility.
const Color bluishCls = AppColors.bluishCls;
const Color yellowCls = AppColors.yellowCls;
const Color pinkCls = AppColors.pinkCls;
const Color white = AppColors.white;
const Color primaryClr = AppColors.primaryClr;
const Color darkGreyCls = AppColors.darkGreyCls;
const Color darkHeaderCls = AppColors.darkHeaderCls;

/// Application theme definitions.
class AppThemes {
  AppThemes._();

  static final ThemeData light = ThemeData(
    useMaterial3: false,
    primaryColor: AppColors.primaryClr,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primaryClr,
      surface: Colors.white,
    ),
  );

  static final ThemeData dark = ThemeData(
    useMaterial3: false,
    primaryColor: AppColors.darkGreyCls,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.darkGreyCls,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primaryClr,
      surface: AppColors.darkGreyCls,
    ),
  );
}

/// Backward compatibility class alias.
class Themes {
  static ThemeData get light => AppThemes.light;
  static ThemeData get dark => AppThemes.dark;
}

