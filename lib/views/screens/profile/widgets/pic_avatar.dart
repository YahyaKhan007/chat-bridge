import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../services/getx_controller/main_controller.dart';

Widget picAvatar({required Size size}) {
  final mainControler = Get.find<ChatBridgeMainController>();

  return Obx(
    () => SizedBox(
      height: 120.h,
      width: 120.w,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100.r),
        child: mainControler.pickedImage.value != null
            ? Image.file(
                File(
                  mainControler.pickedImage.value!.path,
                ),
                fit: BoxFit.cover,
              )
            : Image.network(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRS2NzkYeMmu4mFeDeu4YBeFehLXSzdXU8wag&s',
                fit: BoxFit.cover,
              ),
      ),
    ),
  );
}
