import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hawiah_driver/core/theme/app_colors.dart';

class FooterRegisterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "already_have_an_account".tr(),
          style: TextStyle(color: Color(0xff717177), fontSize: 16.sp),
        ),
        SizedBox(
          width: 5.w,
        ),
        Text(
          "login".tr(),
          style: TextStyle(color: AppColor.mainAppColor, fontSize: 16.sp),
        ),
      ],
    );
  }
}
