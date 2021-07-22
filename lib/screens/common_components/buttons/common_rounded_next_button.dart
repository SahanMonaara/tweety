import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tweety/utils/app_colors.dart';
import 'package:tweety/utils/app_constants.dart';

class CommonRoundedNextButton extends StatefulWidget {
  ///function
  final Function() onPressed;

  CommonRoundedNextButton({
    required this.onPressed,
  });

  @override
  _CommonRoundedNextButtonState createState() =>
      _CommonRoundedNextButtonState();
}

class _CommonRoundedNextButtonState extends State<CommonRoundedNextButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: widget.onPressed,
        child: Container(
          height: AppConstants.adaptiveScreen.setWidth(50),
          width: AppConstants.adaptiveScreen.setWidth(50),
          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(AppConstants.adaptiveScreen.setWidth(30)),
            border: Border.all(
              color: AppColors.primaryButtonBackgroundColor,
            ),
            color: AppColors.primaryButtonBackgroundColor,
          ),
          child: Center(
            child: Icon(
              Icons.arrow_forward,
              color: AppColors.primaryTextColor,
              size: AppConstants.adaptiveScreen.setWidth(20),
            ),
          ),
        ),
      ),
    );
  }
}
