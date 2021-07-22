import 'package:flutter/material.dart';
import 'package:tweety/utils/app_colors.dart';
import 'package:tweety/utils/app_constants.dart';
import 'package:tweety/utils/app_images.dart';
import 'package:tweety/utils/app_text_styles.dart';

class UpperComponent {
  AppTextStyles _styles = AppTextStyles();

  Widget upperBackgroundComponent({
    String title = "",
  }) {
    return Container(
      width: AppConstants.adaptiveScreen.setWidth(428),
      height: AppConstants.adaptiveScreen.setHeight(300),
      decoration: BoxDecoration(
        color: AppColors.primaryBackgroundColor,
        image: DecorationImage(
          image: AssetImage(AppImages.commonBackground),
          fit: BoxFit.fill,
        ),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(
                top: AppConstants.adaptiveScreen.setHeight(70),
              ),
              child: Text(
                title,
                style: _styles.appbarTitleTextStyle(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
