import 'package:easy_localization/easy_localization.dart' as es;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hawiah_driver/core/theme/app_colors.dart';
import 'package:hawiah_driver/features/authentication/presentation/screens/register-screen.dart';

class FooterTextWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "no_account".tr(),
          style: TextStyle(color: Color(0xff717177), fontSize: 16.sp),
        ),
        SizedBox(
          width: 5.w,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const RegisterScreen()));
          },
          child: Text(
            "new_subscription".tr(),
            style: TextStyle(color: AppColor.mainAppColor, fontSize: 16.sp),
          ),
        ),
      ],
    );
  }
}
