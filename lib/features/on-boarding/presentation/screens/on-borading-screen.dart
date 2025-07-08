import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawiah_driver/core/hive/hive_methods.dart';
import 'package:hawiah_driver/core/images/app_images.dart';
import 'package:hawiah_driver/features/on-boarding/presentation/widgets/on-boarding-appBar-widget.dart';
import 'package:hawiah_driver/features/on-boarding/presentation/widgets/on-boarding-content-widget.dart';
import 'package:hawiah_driver/features/on-boarding/presentation/widgets/on-boarding-page-view-widget.dart';

import '../controllers/on-boarding-cubit/on-boarding-cubit.dart';
import '../controllers/on-boarding-cubit/on-boarding-state.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  void initState() {
    HiveMethods.updateFirstTime();
    super.initState();
    Future.microtask(() => OnBoardingCubit.get(context).getOnboarding());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<OnBoardingCubit, OnBoardingState>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = OnBoardingCubit.get(context);

          if (state is OnBoardingLoading) {
            return Center(
                child: Image.asset(
              AppImages.onboarding1,
              fit: BoxFit.fill,
            ));
          }

          if (state is OnBoardingError || cubit.onBoardingList.isEmpty) {
            return const Center(child: Text("حدث خطأ أثناء تحميل البيانات."));
          }

          final currentIndex = cubit.currentIndex;
          final progressValue = cubit.progressValue;
          final pageController = cubit.pageController;

          final onBoardingImages =
              cubit.onBoardingList.map((e) => e.image ?? "").toList();
          final onboardingTitles =
              cubit.onBoardingList.map((e) => e.title?.ar ?? "").toList();
          final onboardingContents =
              cubit.onBoardingList.map((e) => e.about?.ar ?? "").toList();
          final onboardingIcons = List.generate(
            cubit.onBoardingList.length,
            (index) => "",
          );

          return Stack(
            children: [
              OnBoardingPageView(
                onBoardingImages: onBoardingImages,
                pageController: pageController,
                onPageChanged: (index) => cubit.changePageController(index),
              ),
              OnBoardingAppBar(),
              OnBoardingContent(
                currentIndex: currentIndex,
                onboardingIcons: onboardingIcons,
                onboardingTitles: onboardingTitles,
                onboardingContents: onboardingContents,
                progressValue: progressValue,
                pageController: pageController,
                totalImagesCount: onBoardingImages.length,
              ),
            ],
          );
        },
      ),
    );
  }
}
