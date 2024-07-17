// ignore_for_file: must_be_immutable

import 'package:chat_bridge/views/screens/auth_screens/registeration.dart/widgets/textfield_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../blocs/auth_bloc/auth_bloc.dart';
import '../../../utils/utils.dart';
import '../../../widgets/custome_button.dart';
import '../../../widgets/signin_option.dart';

class LoginPage extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  LoginPage({super.key});

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
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        "Login",
                        style: TextStyle(
                            fontSize: 30.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.kcDarkColor),
                      ),
                      24.h.verticalHeight,
                      emailPassColumn(
                          controller: emailController,
                          size: size,
                          key: 'E-mail',
                          hintText: 'Enter your email'),
                      16.h.verticalHeight,
                      emailPassColumn(
                        controller: passwordController,
                        size: size,
                        key: 'Password',
                        hintText: "*******",
                      ),
                      8.h.verticalHeight,
                      Align(
                        alignment: Alignment.centerRight,
                        child: CupertinoButton(
                            child: Text(
                              "Forget Password",
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  color: AppColors.kcBlueColor,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline),
                            ),
                            onPressed: () {}),
                      ),
                      8.h.verticalHeight,
                      customeButton(
                          isCenter: true,
                          buttonText: "Login",
                          textColor: AppColors.kcBackgroundColor,
                          fontWeight: FontWeight.w600,
                          onTap: () {
                            context.read<AuthBloc>().add(LoginEvent(
                                email: emailController.text,
                                password: passwordController.text));
                          },
                          circularRadius: 30.r),
                      16.h.verticalHeight,
                    ],
                  ),
                ),
              ),
            ),
            16.h.verticalHeight,
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24).w,
                  child: Row(
                    children: [
                      Expanded(
                          child: Container(
                        height: 1,
                        color: Colors.grey,
                      )),
                      16.w.horizontalSpace,
                      Text(
                        "Or login with ",
                        style: TextStyle(
                            color: AppColors.kcDarkColor, fontSize: 14.sp),
                      ),
                      16.w.horizontalSpace,
                      Expanded(
                          child: Container(
                        height: 1,
                        color: Colors.grey,
                      ))
                    ],
                  ),
                ),
                16.h.verticalHeight,
                signinOptionWidget(
                    context: context,
                    size: size,
                    image: 'assets/icons/google.png',
                    key: 'Google',
                    buttonText: "Continue with Google",
                    textColor: AppColors.kcDarkColor,
                    horizontalMargin: size.width * 0.05,
                    onTap: () {
                      context.read<AuthBloc>().add(GoogleSignInEvent());
                    }),
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
    required TextEditingController controller,
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
          showCustomTextField(
              isPassword: false, hintText: hintText, controller: controller),
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
