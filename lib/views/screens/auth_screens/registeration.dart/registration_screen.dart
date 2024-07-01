import 'package:chat_bridge/views/screens/auth_screens/registeration.dart/widgets/textfield_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../utils/utils.dart';
import '../../../widgets/custome_button.dart';
import '../../../widgets/terms_and_condition.dart';
import '../../views.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.kcBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.kcBackgroundColor,
        // leadingWidth: 16.w,
        leading: Padding(
            padding: const EdgeInsets.only(left: 16).w,
            child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Container(
                height: 40.h,
                width: 40.w,
                decoration: BoxDecoration(
                    color: AppColors.kcLightColor.withOpacity(0.2),
                    shape: BoxShape.circle),
                child: const Icon(CupertinoIcons.back,
                    color: AppColors.kcDarkColor),
              ),
            )),
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16).w,
                child: Column(
                  children: [
                    Text(
                      "Register",
                      style: TextStyle(
                          fontSize: 30.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.kcDarkColor),
                    ),
                    24.h.verticalHeight,
                    nameRow(size: size),
                    16.h.verticalHeight,
                    emailPassColumn(
                        size: size,
                        key: 'E-mail',
                        hintText: 'Enter your email'),
                    16.h.verticalHeight,
                    emailPassColumn(
                        size: size, key: 'Password', hintText: "*******"),
                    16.h.verticalHeight,
                    emailPassColumn(
                        size: size,
                        key: 'Confirm Password ',
                        hintText: "*******"),
                  ],
                ),
              ),
            ),
            16.h.verticalHeight,
            Column(
              children: [
                customeButton(
                    isCenter: true,
                    buttonText: "Next",
                    textColor: AppColors.kcBackgroundColor,
                    fontWeight: FontWeight.w600,
                    onTap: () {
                      Get.to(() => CompleteProfile());
                    },
                    circularRadius: 30.r),
                16.h.verticalHeight,
                termsAndConditions(size: size),
                32.h.verticalHeight,
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget emailPassColumn({
    required Size size,
    required String key,
    String? hintText,
  }) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            key,
            style: TextStyle(
              color: AppColors.kcDarkColor,
              fontSize: 14.sp,
            ),
          ),
          8.h.verticalSpace,
          showCustomTextField(isPassword: false, hintText: hintText),
        ]);
  }

  Widget nameRow({required Size size}) {
    return SizedBox(
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "First Name",
                  style: TextStyle(
                    color: AppColors.kcDarkColor,
                    fontSize: 14.sp,
                  ),
                ),
                8.h.verticalSpace,
                showCustomTextField(isPassword: false, hintText: "First Name"),
              ],
            ),
          ),
          16.w.horizontalSpace,
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Last Name",
                  style: TextStyle(
                    color: AppColors.kcDarkColor,
                    fontSize: 14.sp,
                  ),
                ),
                8.h.verticalSpace,
                showCustomTextField(isPassword: false, hintText: "Last Name"),
              ],
            ),
          )
        ],
      ),
    );
  }
}
