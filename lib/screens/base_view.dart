import 'package:after_init/after_init.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tweety/utils/app_text_styles.dart';

import 'common_components/background/common_background_lower_component.dart';
import 'common_components/background/common_background_upper_component.dart';

abstract class BaseView extends StatefulWidget {
  BaseView({Key? key}) : super(key: key);
}

abstract class BaseViewState extends State<BaseView>
    with AfterInitMixin<BaseView> {
  ///common variables
  var adaptiveScreen;
  UpperComponent upperComponent = UpperComponent();
  AppTextStyles textStyles = AppTextStyles();
  LowerComponent lowerComponent = LowerComponent();

  ///init state
  @override
  void initState() {
    super.initState();
  }

  ///after init state
  @override
  void didInitState() {
    ScreenUtil.init(
      BoxConstraints(
          minWidth: 0,
          maxWidth: MediaQuery.of(context).size.width,
          minHeight: 0,
          maxHeight: MediaQuery.of(context).size.height),
      designSize: Size(428, 926),
    );
    print(MediaQuery.of(context).size.width);
    print(MediaQuery.of(context).size.height);
    adaptiveScreen = ScreenUtil();
  }

  @override
  Widget build(BuildContext context) {
    return build(context);
  }

}
