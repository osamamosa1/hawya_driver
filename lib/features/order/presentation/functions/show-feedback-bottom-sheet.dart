import 'package:flutter/material.dart';
import 'package:flutter_emoji_feedback/flutter_emoji_feedback.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hawiah_driver/features/order/presentation/functions/show-feedback-bad-bottom-sheet.dart';
import 'package:hawiah_driver/features/order/presentation/functions/show-feedback-complete-bottom-sheet.dart';

void showFeedbackBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      int currentRating = 3;
      return StatefulBuilder(
        builder: (context, setState) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'كيف كانت تجربتك؟',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'يساعدنا تقييمك على تحسين خدماتنا',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ItemFeedback(
                        logo: "assets/icons/terrible_icon.png",
                        title: "سيء جدًا",
                        onTap: () {
                          setState(() {
                            currentRating = 1;
                          });
                           Future.delayed(Duration(seconds: 1), () {
                            Navigator.pop(context);
                            showFeedbackBadBottomSheet(context);
                          });
                          
                        },
                        index: 1,
                        currentRating: currentRating),
                    ItemFeedback(
                        logo: "assets/icons/bad_icon.png",
                        title: "سيء",
                        onTap: () {
                          setState(() {
                            currentRating = 2;
                          });
                        },
                        index: 2,
                        currentRating: currentRating),
                    ItemFeedback(
                        logo: "assets/icons/good_icon.png",
                        title: "جيد",
                        onTap: () {
                          setState(() {
                            currentRating = 3;
                          });
                        },
                        index: 3,
                        currentRating: currentRating),
                    ItemFeedback(
                        logo: "assets/icons/very_good_icon.png",
                        title: "جيد جدًا",
                        onTap: () {
                          setState(() {
                            currentRating = 4;
                          });
                        },
                        index: 4,
                        currentRating: currentRating),
                    ItemFeedback(
                        logo: "assets/icons/awesome_icon.png",
                        title: "رائع",
                        onTap: () {
                          setState(() {
                            currentRating = 5;
                          });
                          Future.delayed(Duration(seconds: 1), () {
                            Navigator.pop(context);
                            showThankYouBottomSheet(context);
                          });
                        },
                        index: 5,
                        currentRating: currentRating),
                  ],
                ),
                SizedBox(height: 16),
              ],
            ),
          );
        },
      );
    },
  );
}

Widget ItemFeedback(
    {required String logo,
    required String title,
    required VoidCallback onTap,
    required int index,
    required int currentRating}) {
  return GestureDetector(
    onTap: onTap,
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                index != currentRating
                    ? Color(0xffEFF0F6)
                    : Color(0xFFFF00FF), // #FF00FF
                index != currentRating
                    ? Color(0xffEFF0F6)
                    : Color(0xFF9116F9), // #9116F9
                index != currentRating
                    ? Color(0xffEFF0F6)
                    : Color(0xFF3199FF), // #3199FF
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Image.asset(
            logo,
            height: index == currentRating ? 40.h : 30.h,
            width: index == currentRating ? 40.w : 30.w,
          ),
        ),
        SizedBox(height: 8),
        index == currentRating
            ? Text(
                title,
                style: TextStyle(fontSize: 16),
              )
            : SizedBox.shrink(),
      ],
    ),
  );
}
