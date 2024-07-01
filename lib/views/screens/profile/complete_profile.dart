import 'package:chat_bridge/services/getx_controller/main_controller.dart';
import 'package:chat_bridge/views/screens/auth_screens/registeration.dart/email_pass_column.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../blocs/splash/splash_bloc.dart';
import '../../utils/utils.dart';
import '../../widgets/custome_button.dart';
import '../../widgets/terms_and_condition.dart';
import 'widgets/pic_avatar.dart';
import 'widgets/select_interested_language.dart';
import 'widgets/show_interested_languages.dart';

// ignore: must_be_immutable
class CompleteProfile extends StatelessWidget {
  CompleteProfile({super.key});

  TextEditingController interestController = TextEditingController();
  FocusNode interestFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        "Profile",
                        style: TextStyle(
                            fontSize: 30.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.kcDarkColor),
                      ),
                      24.h.verticalHeight,
                      picAvatar(size: size),
                      8.h.verticalHeight,
                      BlocBuilder<SplashBloc, SplashState>(
                        builder: (context, state) {
                          return Text(
                            state.currentUser?.fullName ?? 'UnKnown',
                            style: TextStyle(
                                color: AppColors.kcDarkColor,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold),
                          );
                        },
                      ),
                      16.h.verticalHeight,
                      fieldColumn(
                          size: size,
                          key: 'Country',
                          hintText: 'Enter your Country name'),
                      16.h.verticalHeight,
                      fieldColumn(
                          size: size,
                          key: 'City',
                          hintText: 'Enter your City name'),
                      16.h.verticalHeight,
                      fieldColumn(
                          size: size,
                          key: 'Native Language',
                          hintText: "Enter Native Language"),
                      16.h.verticalHeight,
                      selectInterest(
                          size: size,
                          controller: interestController,
                          interestFocus: interestFocus),
                      16.h.verticalHeight,
                      showInterestedlanguages(),
                      16.h.verticalHeight,
                    ],
                  ),
                ),
              ),
            ),
            16.h.verticalHeight,
            Column(
              children: [
                customeButton(
                    isCenter: true,
                    buttonText: "Confirm",
                    textColor: AppColors.kcBackgroundColor,
                    fontWeight: FontWeight.w600,
                    onTap: () {
                      // Get.to(() => const CompleteProfile());
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
}
