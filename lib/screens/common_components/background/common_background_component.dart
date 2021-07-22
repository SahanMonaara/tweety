import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tweety/configurations/google_sign_in_provider.dart';
import 'package:tweety/utils/app_constants.dart';
import 'package:tweety/utils/app_text_styles.dart';
import 'package:tweety/utils/injection_container.dart';

import 'common_background_lower_component.dart';
import 'common_background_upper_component.dart';

class CommonBackgroundComponent extends StatefulWidget {
  /// pass list of Children wrap with positioned or Alignment widget
  final List<Widget> children;

  ///Enable AppBar title , pass title to pageTitle argument
  final String pageTitle;

  ///To set height of bottom sheet pass double value for bottomSheetHeight
  final double bottomSheetHeight;

  ///To enable back button pass true for backButton
  final bool profile;

  ///For the profile image
  final String profileImage;

  ///For the user name
  final String name;

  ///For the user email
  final String email;

  CommonBackgroundComponent(
      {required this.children,
      this.pageTitle = '',
      this.bottomSheetHeight = 780,
      this.profile = false,
      this.profileImage = '',
      this.name = '',
        this.email = ''});

  @override
  _CommonBackgroundComponentState createState() =>
      _CommonBackgroundComponentState();
}

class _CommonBackgroundComponentState extends State<CommonBackgroundComponent> {
  final up = sl<UpperComponent>();
  final low = sl<LowerComponent>();
  final style = sl<AppTextStyles>();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        up.upperBackgroundComponent(title: widget.pageTitle),
        low.lowerBackGroundComponent(height: widget.bottomSheetHeight),
        widget.profile
            ? Stack(
                children: [
                  Positioned(
                    top: AppConstants.adaptiveScreen.setHeight(40),
                    left: AppConstants.adaptiveScreen.setWidth(20),
                    child: CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(widget.profileImage),
                    ),
                  ),
                  Positioned(
                    top: AppConstants.adaptiveScreen.setHeight(90),
                    left: AppConstants.adaptiveScreen.setWidth(20),
                    child: Column(
                      mainAxisAlignment:MainAxisAlignment.start ,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.name,
                          style: style.commonTextStyle()
                        ),Text(
                          widget.email,
                          style: style.commonSubTitleTextStyle()
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: AppConstants.adaptiveScreen.setHeight(10),
                    top: AppConstants.adaptiveScreen.setWidth(30),
                    child: TextButton(
                      onPressed: () {
                        final provider = Provider.of<GoogleSignInProvider>(
                            context,
                            listen: false);
                        provider.Logout();
                      },
                      child: Text('Sign Out',style: style.commonTextStyle(),),
                    ),
                  )
                ],
              )
            : SizedBox(),
        Stack(
          children: widget.children,
        )
      ],
    );
  }
}
