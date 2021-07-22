import 'package:flutter/material.dart';
import 'package:tweety/utils/app_colors.dart';
import 'package:tweety/utils/app_constants.dart';
import 'package:tweety/utils/app_text_styles.dart';
import 'package:tweety/utils/injection_container.dart';

class CommonTextFormField extends StatefulWidget {
  final String inputTitle;
  final TextEditingController controller;

  ///always add suffix with size:adaptiveScreen.setWidth(20)
  final Widget suffix;
  final bool obscureText;
  final Function(String a) onSubmitComplete;

  CommonTextFormField(
      {required this.inputTitle,
      required this.controller,
      required this.suffix,
      this.obscureText = false,
      required this.onSubmitComplete});

  @override
  _CommonTextFormFieldState createState() => _CommonTextFormFieldState();
}

class _CommonTextFormFieldState extends State<CommonTextFormField> {
  final style = sl<AppTextStyles>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppConstants.adaptiveScreen.setWidth(390),
      height: AppConstants.adaptiveScreen.setHeight(100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: AppConstants.adaptiveScreen.setHeight(3),
          ),
          Text(
            widget.inputTitle,
            style: style.commonTextFormFieldTextStyle(),
          ),
          SizedBox(
            height: AppConstants.adaptiveScreen.setHeight(3),
          ),
          Container(
            color: AppColors.textFieldBackgroundColor,
            height: AppConstants.adaptiveScreen.setHeight(65),
            child: Center(
              child: TextFormField(
                obscureText: widget.obscureText,
                scrollPadding: EdgeInsets.all(0),
                textAlignVertical: TextAlignVertical.top,
                controller: widget.controller,
                decoration: InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(
                      left: AppConstants.adaptiveScreen.setWidth(12),
                      right: AppConstants.adaptiveScreen.setWidth(12),
                    ),
                    suffix: widget.suffix),
                onEditingComplete: widget.onSubmitComplete("true"),
              ),
            ),
          )
        ],
      ),
    );
  }
}
