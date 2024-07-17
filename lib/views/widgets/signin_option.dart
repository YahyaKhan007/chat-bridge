import 'package:chat_bridge/views/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget signinOptionWidget(
    {required BuildContext context,
    required Size size,
    required String key,
    required String buttonText,
    String? image,
    double? textSize,
    Color? textColor,
    double? horizontalMargin,
    required VoidCallback onTap,
    Color? color}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.symmetric(
          vertical: image != null ? 8.h : 12.h, horizontal: 16.w),
      margin: EdgeInsets.symmetric(horizontal: horizontalMargin ?? 32.w),
      width: size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.r),
          border: Border.all(color: AppColors.kcLightColor, width: 1.5),
          color: color ?? AppColors.kcBackgroundColor),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Visibility(
            visible: image != null ? true : false,
            child: image != null ? Image.asset(image) : const SizedBox(),
          ),
          8.w.horizontalSpace,
          Center(
            child: Text(
              buttonText,
              style: TextStyle(
                fontSize: textSize ?? 12.sp,
                color: textColor ?? AppColors.kcLightColor,
              ),
            ),
          )
        ],
      ),
    ),
  );
}
