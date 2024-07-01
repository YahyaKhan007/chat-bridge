import 'package:chat_bridge/views/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget showCustomTextField({
  String? hintText,
  TextEditingController? controller,
  required bool isPassword,
}) {
  return TextFormField(
    controller: controller,
    style: TextStyle(
        fontSize: 12.sp,
        color: AppColors.kcDarkColor,
        fontWeight: FontWeight.normal),
    decoration: InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(
          fontSize: 12.sp,
          color: AppColors.kcLightColor,
          fontWeight: FontWeight.normal),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8).r,
      ),
    ),
  );
}
