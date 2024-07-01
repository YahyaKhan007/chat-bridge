// ignore_for_file: must_be_immutable

import 'package:chat_bridge/views/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'custome_button.dart';

class OnBoardingBottomButtons extends StatelessWidget {
  VoidCallback onSkip;
  VoidCallback onContinue;
  OnBoardingBottomButtons(
      {super.key, required this.onSkip, required this.onContinue});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20,
      left: 20.w,
      right: 20.w,
      child: FittedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: CustomButton(
                onTap: onSkip,
                buttonText: 'Skip',
                backgroundColor: Colors.white,
                borderColor: AppColors.kcBlueColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: CustomButton(
                color: AppColors.kcBackgroundColor,
                onTap: onContinue,
                backgroundColor: AppColors.kcDarkColor,
                buttonText: 'Continue',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
