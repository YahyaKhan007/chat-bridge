import 'package:chat_bridge/services/getx_controller/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../utils/utils.dart';

class DashboardScreen extends StatelessWidget {
   DashboardScreen({super.key});

  final List<Widget> allPages = [
    
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 8).h,
        child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 22).w,
            height: size.height * 0.15,
            width: size.width * 0.8,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: AppColors.kcNavBarColor),
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24).w,
                child:
                    GetBuilder<ChatBridgeMainController>(builder: (controller) {
                  return Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        navBarItem(
                            imagePath: 'assets/icons/home_svg.svg',
                            label: 'Home',
                            index: 0,
                            onTap: () {
                              controller.currentIndex.value = 0;
                            }),
                        navBarItem(
                            imagePath: 'assets/icons/message_svg.svg',
                            label: 'Messages',
                            index: 1,
                            onTap: () {
                              controller.currentIndex.value = 1;
                            }),
                        navBarItem(
                            index: 2,
                            imagePath: 'assets/icons/heart_svg.svg',
                            label: 'Special',
                            onTap: () {
                              controller.currentIndex.value = 2;
                            }),
                        navBarItem(
                            index: 3,
                            imagePath: 'assets/icons/profile_svg.svg',
                            label: 'Profile',
                            onTap: () {
                              controller.currentIndex.value = 3;
                            }),
                      ],
                    ),
                  );
                }))),
      ),
    );
  }

  Widget navBarItem(
      {required String imagePath,
      required String label,
      required VoidCallback onTap,
      required int index}) {
    final mainController = Get.find<ChatBridgeMainController>();
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            imagePath,
            color: mainController.currentIndex.value == index
                ? AppColors.kcBackgroundColor
                : AppColors.kcLightColor,
            height: mainController.currentIndex.value == index ? 30.h : 25.h,
          ),
          4.h.verticalSpace,
          Text(
            label,
            style: TextStyle(
              color: mainController.currentIndex.value == index
                  ? AppColors.kcBackgroundColor
                  : AppColors.kcLightColor,
              fontSize:
                  mainController.currentIndex.value == index ? 16.sp : 14.sp,
            ),
          )
        ],
      ),
    );
  }
}
