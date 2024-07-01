import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../services/getx_controller/main_controller.dart';
import '../../../utils/utils.dart';

Widget selectInterest(
    {required Size size,
    required TextEditingController controller,
    required FocusNode interestFocus}) {
  final mainController = Get.find<ChatBridgeMainController>();

  controller.addListener(() {
    mainController.addInterets.value = controller.text.isNotEmpty;
  });

  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Language Interest",
        style: TextStyle(
          color: AppColors.kcDarkColor,
          fontSize: 14.sp,
        ),
      ),
      8.h.verticalSpace,
      Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: AppColors.kcLightColor),
          ),
          padding: EdgeInsets.only(left: 16.w, top: 4.h, bottom: 4.h),
          child: TextFormField(
            controller: controller,
            focusNode: interestFocus,
            style: TextStyle(fontSize: 12.sp, color: AppColors.kcDarkColor),
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter Language and Press Add',
                hintStyle: TextStyle(
                  fontSize: 12.sp,
                ),
                suffixIcon: Obx(
                  () => mainController.addInterets.value
                      ? GestureDetector(
                          onTap: () {
                            mainController.interestedLanguagelist
                                .add(controller.text);

                            controller.clear();
                            interestFocus.unfocus();
                          },
                          child: Container(
                            width: size.width * 0.2,
                            // padding:
                            //     EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                            decoration: BoxDecoration(
                              color: AppColors.kcDarkColor,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Center(
                              child: Text(
                                "Add",
                                style: TextStyle(
                                    color: AppColors.kcBackgroundColor,
                                    fontSize: 12.sp),
                              ),
                            ),
                          ),
                        )
                      : const Icon(
                          Icons.add,
                          color: AppColors.kcDarkColor,
                        ),
                )),
          )),
    ],
  );
}
