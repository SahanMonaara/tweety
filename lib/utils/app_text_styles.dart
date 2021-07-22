import 'package:flutter/cupertino.dart';

import 'app_colors.dart';
import 'app_constants.dart';

class AppTextStyles {
  TextStyle appbarTitleTextStyle() {
    return TextStyle(
        color: AppColors.primaryTextColor,
        fontSize: AppConstants.adaptiveScreen.setSp(33),
        fontWeight: FontWeight.bold);
  }

  TextStyle commonButtonTextStyle() {
    return TextStyle(
        color: AppColors.primaryTextColor,
        fontWeight: FontWeight.bold,
        fontSize: AppConstants.adaptiveScreen.setSp(25));
  }

  TextStyle commonTextFormFieldTextStyle() {
    return TextStyle(
      color: AppColors.primaryButtonBackgroundColor,
      fontSize: AppConstants.adaptiveScreen.setSp(18),
    );
  }

  TextStyle loginPageSignWithTextStyle() {
    return TextStyle(
        color: AppColors.primaryButtonBackgroundColor,
        fontSize: AppConstants.adaptiveScreen.setSp(18),
        fontWeight: FontWeight.bold);
  }
  TextStyle commonTextStyle() {
    return TextStyle(
        color: AppColors.primaryTextColor,
        fontSize: AppConstants.adaptiveScreen.setSp(20),
        fontWeight: FontWeight.bold);
  }
  TextStyle commonSubTitleTextStyle() {
    return TextStyle(
        color: AppColors.primaryTextColor,
        fontSize: AppConstants.adaptiveScreen.setSp(14),
        fontWeight: FontWeight.normal);
  }
}
