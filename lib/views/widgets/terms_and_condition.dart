 import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/utils.dart';

Widget termsAndConditions({required Size size}) {
    return FittedBox(
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "By continuing, you agree to our",
                style: TextStyle(
                    color: AppColors.kcLightColor,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.normal),
              ),
              Text(
                " Terms of Service",
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: AppColors.kcBlueColor,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "and ",
                style: TextStyle(
                    color: AppColors.kcLightColor,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "Privacy Policy",
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: AppColors.kcBlueColor,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ],
      ),
    );
  }