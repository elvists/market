import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

abstract class AppStyles {
  static final inputDecoration = ({String hint, @required IconData icon, bool withLabel = false}) => InputDecoration(
      hintText: hint,
      labelText: withLabel ? hint : null,
      hintStyle: AppTextStyles.textStyleHint,
      contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
      border: OutlineInputBorder(),
      focusedBorder: _border(AppColors.blue, width: 2.0),
      enabledBorder: _border(AppColors.lightGray),
      prefixIcon: Icon(icon));

  static OutlineInputBorder _border(Color color, {double width = 1.0}) => OutlineInputBorder(
        borderSide: BorderSide(
          color: color,
          width: width,
        ),
      );
}
