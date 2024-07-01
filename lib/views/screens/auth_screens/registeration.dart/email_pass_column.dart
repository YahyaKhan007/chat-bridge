import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/utils.dart';
import 'widgets/textfield_widget.dart';

Widget fieldColumn({
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
