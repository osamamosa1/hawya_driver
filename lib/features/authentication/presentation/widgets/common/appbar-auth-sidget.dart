import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hawiah_driver/core/images/app_images.dart';
import 'package:hawiah_driver/features/app-language/presentation/screens/app-language-screen.dart';

class AppBarAuthWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarAuthWidget({
    super.key,
  });

  @override
  Size get preferredSize =>
      Size.fromHeight(60.h); // Set preferred height for AppBar

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      actions: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            children: [
              SvgPicture.asset(
                AppImages.supportIcon,
                height: 25.h,
                width: 25.w,
                fit: BoxFit.fill,
              ),
              SizedBox(width: 10.w),
              GestureDetector(
                onTap: () {
                  Navigator.push<void>(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) =>
                          const AppLanguageScreen(
                        isOnBoarding: false,
                      ),
                    ),
                  );
                },
                child: SvgPicture.asset(
                  AppImages.langIcon,
                  height: 25.h,
                  width: 25.w,
                  fit: BoxFit.fill,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
