import 'package:chat_bridge/services/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../blocs/onboarding_bloc/on_boarding_bloc.dart';
import '../../utils/app_colors.dart';
import 'widgets/custome_button.dart';
import 'widgets/onboarding_bottom_buttons.dart';
import 'widgets/widgets.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<OnBoardingBloc, OnBoardingState>(
        builder: (context, state) {
          return Stack(children: [
            PageView(
              
              controller: state.pageController,
              onPageChanged: (index) {
                context
                    .read<OnBoardingBloc>()
                    .add(ChangePageEvent(index: index));
              },
              children: const [
                OnBoarding(
                  imageAssetPath: 'assets/images/onboard_1.jpg',
                  titleText: 'توصيات',
                  subtitleText:
                      "تابع أحدث التوصيات عبر تطبيق الوجداني لحظة بالحظة ",
                ),
                OnBoarding(
                  imageAssetPath: 'assets/images/onboard_2.jpg',
                  titleText: 'احدث الاخبار والتقارير',
                  subtitleText:
                      'احصل على اخر الاخبار والتقارير التي \nسوف تساعدك على معرفة السوق',
                ),
                OnBoarding(
                  imageAssetPath: 'assets/images/onboard_3.jpg',
                  titleText: 'باقات وخيارات متعددة',
                  subtitleText:
                      'من المهم جدًا أن يتابع العميل تدريب\n العميل، ولكنه في نفس وقت العمل',
                ),
              ],
            ),
            Positioned(
                bottom: MediaQuery.of(context).size.height * 0.27,
                left: 0,
                right: 0,
                // left: MediaQuery.of(context).size.width /,
                child: Align(
                  alignment: Alignment.center,
                  child: SmoothPageIndicator(
                    controller: state.pageController,
                    onDotClicked: (int index) {
                      context
                          .read<OnBoardingBloc>()
                          .add(ChangePageEvent(index: index));
                    },
                    count: 3,
                    effect: const ExpandingDotsEffect(
                        activeDotColor: Colors.black, dotHeight: 10),
                  ),
                )),
            Positioned(
              bottom: 20.h,
              left: 40.w,
              right: 40.w,
              child: Visibility(
                visible: state.currentPage == 2 ? true : false,
                child: CustomButton(
                  onTap: () {
                    GetStorage().write('isFirstTime', false);
                    Get.offAllNamed(RouterHelper.getStarted);
                  },
                  buttonText: 'Get Started',
                  color: AppColors.kcBackgroundColor,
                  backgroundColor: AppColors.kcDarkColor,
                ),
              ),
            ),
            Visibility(
              visible: state.currentPage != 2 ? true : false,
              child: OnBoardingBottomButtons(
                onSkip: () {
                  GetStorage().write('isFirstTime', false);
                  Get.offAllNamed(RouterHelper.getStarted);
                },
                onContinue: () {
                  context
                      .read<OnBoardingBloc>()
                      .add(ChangePageEvent(index: state.currentPage + 1));
                },
              ),
            ),
          ]);
        },
      ),
    );
  }
}
