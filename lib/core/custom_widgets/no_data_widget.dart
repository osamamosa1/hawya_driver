import 'package:flutter/material.dart';
import 'package:hawiah_driver/core/extension/context_extension.dart';
import 'package:hawiah_driver/core/images/app_images.dart';
import 'package:hawiah_driver/core/theme/app_colors.dart';
import 'package:hawiah_driver/core/theme/app_theme.dart';


class NoDataWidget extends StatelessWidget {
  final Axis axis;
  final String? message;
  final String? assetImage;
  const NoDataWidget({
    super.key,
    this.axis = Axis.vertical,
    this.message,
    this.assetImage,
  });

  @override
  Widget build(BuildContext context) {
    switch (axis) {
      case Axis.horizontal:
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          decoration: BoxDecoration(
            color: AppColor.mainAppColor.withValues(alpha: 0),
            borderRadius: BorderRadius.circular(7),
          ),
          child: IntrinsicHeight(
            child: Row(
              children: [
                Image.asset(
                  assetImage ?? AppImages.noDataImage,

                  width: 100,
                  height: 100,
                  fit: BoxFit.contain,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      message ??
                          context.apiTr(
                            ar: "لا توجد بيانات",
                            en: "There is no data",
                          ),
                      style: TextStyle(
                        color: AppTheme.getByTheme(
                          light: Colors.black,
                          dark: Colors.white,
                        ),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );

      case Axis.vertical:
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          decoration: BoxDecoration(
            color: AppColor.mainAppColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(7),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                AppImages.noDataImage,

                width: 100,
                height: 100,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 10),
              Text(
                message ??
                    context.apiTr(ar: "لا توجد بيانات", en: "There is no data"),
                style: TextStyle(
                  color: AppTheme.getByTheme(
                    light: Colors.black,
                    dark: Colors.white,
                  ),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
    }
  }
}
