import 'package:chat_bridge/views/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget customeButton(
    {Color? backgroundColor,
    Color? textColor,
    double? textSize,
    String? buttonText,
    double? buttonSize,
    double? circularRadius,
    double? buttonHeight,
    FontWeight? fontWeight,
    bool? isCenter,
    VoidCallback? onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 50,
      width: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(circularRadius ?? 10),
        color: backgroundColor ?? AppColors.kcDarkColor,
      ),
      child: isCenter != null && isCenter == true
          ? Center(
              child: Text(
                buttonText ?? "No Button Text",
                style: TextStyle(
                  fontStyle: FontStyle.normal,
                  fontSize: textSize ?? 12.sp,
                  color: textColor ?? AppColors.kcLightColor,
                  fontWeight: fontWeight ?? FontWeight.normal,
                ),
              ),
            )
          : Text(
              buttonText ?? "No Button Text",
              style: TextStyle(
                fontStyle: FontStyle.normal,
                fontSize: textSize ?? 12.sp,
                color: textColor ?? AppColors.kcLightColor,
                fontWeight: fontWeight ?? FontWeight.normal,
              ),
            ),
    ),
  );
}
