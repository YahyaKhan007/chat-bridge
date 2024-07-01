import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../services/getx_controller/main_controller.dart';
import '../../../utils/utils.dart';

Widget showInterestedlanguages() {
  final mainController = Get.find<ChatBridgeMainController>();
  return Obx(
    () => Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      alignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.start,
      direction: Axis.horizontal,
      runAlignment: WrapAlignment.start,
      verticalDirection: VerticalDirection.down,
      clipBehavior: Clip.none,
      children: List.generate(
          mainController.interestedLanguagelist.length,
          (index) => Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: AppColors.kcLightColor),
                ),
                child: Text(
                  mainController.interestedLanguagelist[index],
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.kcDarkColor,
                  ),
                ),
              )),
    ),
  );
}
