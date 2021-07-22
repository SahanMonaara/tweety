import 'package:flutter/material.dart';
import 'package:tweety/utils/app_colors.dart';
import 'package:tweety/utils/app_constants.dart';

class LowerComponent {
  Widget lowerBackGroundComponent({double height = 400}) {
    return Positioned(
      top: AppConstants.adaptiveScreen.setHeight(926 - height),
      child: Container(
        height: AppConstants.adaptiveScreen.setHeight(height),
        width: AppConstants.adaptiveScreen.setWidth(428),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(
              AppConstants.adaptiveScreen.setWidth(60),
            ),
            topRight: Radius.circular(
              AppConstants.adaptiveScreen.setWidth(60),
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: AppConstants.adaptiveScreen.setWidth(10),
              blurRadius: AppConstants.adaptiveScreen.setWidth(10),
              offset: Offset(5, 0),
            ),
          ],
        ),
      ),
    );
  }
}
