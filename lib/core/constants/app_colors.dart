import 'package:flutter/material.dart';

/// Application color palette constants.
class AppColors {
  AppColors._();

  static const Color primaryClr = Color(0xFF4e5ae8);
  static const Color bluishCls = Color(0xFF4e5ae8);
  static const Color yellowCls = Color(0xFFFFB746);
  static const Color pinkCls = Color(0xFFff4667);
  static const Color white = Colors.white;
  static const Color darkGreyCls = Color(0xFF121212);
  static const Color darkHeaderCls = Color(0xFF424242);

  /// Task card color mapping by index.
  static Color getTaskColor(int index) {
    switch (index) {
      case 0:
        return bluishCls;
      case 1:
        return pinkCls;
      case 2:
        return yellowCls;
      default:
        return bluishCls;
    }
  }
}
