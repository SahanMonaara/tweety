import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tweety/utils/app_colors.dart';
import 'package:tweety/utils/app_constants.dart';
import 'package:tweety/utils/app_text_styles.dart';
import 'package:tweety/utils/injection_container.dart';

class CommonElevatedButton extends StatefulWidget {
  ///title of the button
  final String title;

  ///button width (by default width was set. if want to change add width-only value)
  final double width;

  ///function
  final Function() onPressed;

  ///background color (by default primary color was set)
  final Color backgroundColor;

  ///Icon
  final FaIcon icon;

  CommonElevatedButton({
    this.title = '',
    this.width = 300,
    required this.onPressed,
    this.backgroundColor = AppColors.primaryButtonBackgroundColor,
    required this.icon,
  });

  @override
  _CommonElevatedButtonState createState() => _CommonElevatedButtonState();
}

class _CommonElevatedButtonState extends State<CommonElevatedButton> {
  final _styles = sl<AppTextStyles>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton.icon(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
          primary: widget.backgroundColor,
          fixedSize: Size(AppConstants.adaptiveScreen.setWidth(widget.width),
              AppConstants.adaptiveScreen.setHeight(55)),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  AppConstants.adaptiveScreen.setWidth(35))),
        ),
        icon: widget.icon,
        label: Text(
          widget.title,
          style: _styles.commonButtonTextStyle(),
        ),
      ),
    );
  }
}
