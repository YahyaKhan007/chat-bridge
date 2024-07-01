import 'dart:developer';

import 'package:chat_bridge/blocs/auth_bloc/auth_bloc.dart';
import 'package:chat_bridge/views/screens/auth_screens/get_started/widgets/signin_option.dart';
import 'package:chat_bridge/views/utils/app_colors.dart';
import 'package:chat_bridge/views/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../services/routes/routes.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.kcBackgroundColor,
      body: Stack(
        children: [
          SizedBox(
            height: size.height,
            width: size.width,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  80.h.verticalSpace,
                  Text(
                    "Let's Get Started!",
                    style: TextStyle(
                        fontSize: 30.sp,
                        color: AppColors.kcDarkColor,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "With Splitify, expenses split bills is easier\nhan ever before",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.kcLightColor,
                        fontWeight: FontWeight.w100),
                  ),
                  40.h.verticalSpace,
                  signinOptionWidget(
                      context: context,
                      size: size,
                      image: 'assets/icons/google.png',
                      key: 'Google',
                      buttonText: "Continue with Google",
                      onTap: () {
                        context.read<AuthBloc>().add(GoogleSignInEvent());
                      }),
                  16.h.verticalSpace,
                  signinOptionWidget(
                      context: context,
                      size: size,
                      image: 'assets/icons/apple.png',
                      key: 'Apple',
                      buttonText: "Continue with Google",
                      onTap: () {}),
                  16.h.verticalSpace,
                  signinOptionWidget(
                      context: context,
                      size: size,
                      image: 'assets/icons/facebook.png',
                      key: 'Facebook',
                      buttonText: "Continue with Google",
                      onTap: () {}),
                  16.h.verticalSpace,
                  signinOptionWidget(
                      context: context,
                      size: size,
                      image: 'assets/icons/twitter.png',
                      key: 'Twitter',
                      buttonText: "Continue with Google",
                      onTap: () {}),
                  40.h.verticalSpace,
                  signinOptionWidget(
                      context: context,
                      size: size,
                      color: AppColors.kcDarkColor,
                      key: 'Signup',
                      textColor: AppColors.kcBackgroundColor,
                      buttonText: "Sign Up",
                      horizontalMargin: size.width * 0.2,
                      onTap: () {
                        Get.toNamed(RouterHelper.register);
                      }),
                  8.h.verticalSpace,
                  signinOptionWidget(
                      context: context,
                      size: size,
                      // color: AppColors.kcDarkColor,
                      key: 'login',
                      textColor: AppColors.kcDarkColor,
                      buttonText: "Log in",
                      horizontalMargin: size.width * 0.2,
                      onTap: () {}),
                  48.h.verticalSpace,
                  Text(
                    "Privacy Policy - Terms of service",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.kcLightColor,
                        fontWeight: FontWeight.w100),
                  ),
                ],
              ),
            ),
          ),
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return Visibility(
                  visible: state.isLoading,
                  child: Container(
                    decoration:
                        BoxDecoration(color: Colors.black.withOpacity(0.4)),
                    child: Center(
                      child: loadingWidgetInkDrop(
                          size: 30.r, color: AppColors.kcBackgroundColor),
                    ),
                  ));
            },
          )
        ],
      ),
    );
  }
}
