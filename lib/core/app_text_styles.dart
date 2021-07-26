import 'package:flutter/material.dart';
import 'app_colors.dart';

abstract class AppTextStyles {
  static const textStyleInfo = TextStyle(
    fontSize: 16,
    color: AppColors.gray,
    fontWeight: FontWeight.normal,
  );

  static const textStyleSmallInfo = TextStyle(
    fontSize: 12,
    color: AppColors.gray,
    fontWeight: FontWeight.normal,
  );

  static const textStyleTitle = TextStyle(
    fontSize: 21,
    color: AppColors.darkGray,
    fontWeight: FontWeight.bold,
  );

  static const textStyleSmallTitle = TextStyle(
    fontSize: 16,
    color: AppColors.darkGray,
    fontWeight: FontWeight.bold,
  );

  static const textStyleHint = TextStyle(
    fontSize: 16,
    color: AppColors.lightGray,
  );

  static const textStyleLabel = TextStyle(
    fontSize: 14,
    color: AppColors.gray,
  );
  static const textStyleValue = TextStyle(
    fontSize: 16,
    color: AppColors.darkGray,
  );

  static const textStyleExpansionTileTitle = TextStyle(
    fontSize: 18,
    color: AppColors.darkGray,
    fontWeight: FontWeight.bold,
  );
}
