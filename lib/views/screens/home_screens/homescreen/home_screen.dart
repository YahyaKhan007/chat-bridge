import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_bridge/blocs/chat_bloc/chat_bloc.dart';
import 'package:chat_bridge/services/getx_controller/main_controller.dart';
import 'package:chat_bridge/views/utils/app_colors.dart';
import 'package:chat_bridge/views/widgets/loading_widget/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ChatBridgeMainController mainController =
        Get.find<ChatBridgeMainController>();

    log(mainController.currentUserModel.value!.uid);

    return Scaffold(
      body: Obx(
        () => SizedBox(
          height: size.height,
          width: size.width,
          child: mainController.allUsers.isEmpty
              ? loadingWidgetInkDrop(size: 30.r, color: AppColors.kcDarkColor)
              : PageView.builder(
                  itemCount: mainController.allUsers.length,
                  itemBuilder: (context, index) => Stack(
                    children: [
                      Container(
                        height: size.height * 0.55,
                        width: size.width,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: CachedNetworkImageProvider(
                                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT6UC2VRLbRRbsduq3MX8aNLfUR5RweLFLRVJzxx6xvssNSeQYlanpHm_rf0cFD-sr0i4I&usqp=CAU',
                                ),
                                fit: BoxFit.cover)),
                        child: userInfo(context, size: size, index: index),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          height: size.height * 0.5,
                          width: size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(32.r),
                                topRight: Radius.circular(32.r)),
                            color: Colors.black,
                          ),
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: SizedBox(
                              height: size.height * 0.375,
                              width: size.width,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 24.h, horizontal: 24.w),
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "About",
                                        style: TextStyle(
                                            color: AppColors.kcBackgroundColor,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "A good listener, I love having a good talk to know each other’s side ❤️",
                                        style: TextStyle(
                                            color: AppColors.kcLightColor,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      8.h.verticalSpace,
                                      Text(
                                        "Interested Lannguages",
                                        style: TextStyle(
                                            color: AppColors.kcBackgroundColor,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Wrap(
                                        spacing: 0,
                                        runSpacing: 0,
                                        alignment: WrapAlignment.start,
                                        crossAxisAlignment:
                                            WrapCrossAlignment.start,
                                        direction: Axis.horizontal,
                                        runAlignment: WrapAlignment.start,
                                        verticalDirection:
                                            VerticalDirection.down,
                                        clipBehavior: Clip.none,
                                        children: List.generate(
                                            8,
                                            (index) => SizedBox(
                                                height: 48.h,
                                                width: 100.w,
                                                child: const Card())),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                          bottom: size.height * 0.08,
                          left: 0,
                          right: 0,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Visibility(
                                  child: CircleAvatar(
                                backgroundColor: AppColors.kcLightColor,
                                radius: 24.r,
                              )),
                              16.w.horizontalSpace,
                              Visibility(
                                  child: CircleAvatar(
                                backgroundColor: AppColors.kcLightColor,
                                radius: 24.r,
                              )),
                              16.w.horizontalSpace,
                              Visibility(
                                  child: CircleAvatar(
                                backgroundColor: AppColors.kcLightColor,
                                radius: 24.r,
                              ))
                            ],
                          ))
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  Widget userInfo(BuildContext context,
      {required Size size, required int index}) {
    ChatBridgeMainController mainController =
        Get.find<ChatBridgeMainController>();
    return Column(
      children: [
        32.h.verticalSpace,
        Align(
          alignment: AlignmentDirectional.topEnd,
          child: Container(
            margin: EdgeInsets.only(right: 16.w),
            height: 24.h,
            width: 80.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32.r),
                color: AppColors.kcGreen),
            child: Center(
              child: Text(
                "2.5 km",
                style: TextStyle(
                    color: AppColors.kcBackgroundColor,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        const Spacer(),
        Center(
          child: Text(
            mainController.allUsers[index].fullName,
            style: TextStyle(
                color: AppColors.kcBackgroundColor,
                fontSize: 26.sp,
                fontWeight: FontWeight.bold),
          ),
        ),
        Center(
          child: Text(
            "HAMBERG, GERMANY",
            style: TextStyle(
                color: AppColors.kcBackgroundColor,
                fontSize: 10.sp,
                fontWeight: FontWeight.bold),
          ),
        ),
        16.h.verticalSpace,
        Center(
          child: Container(
            margin: EdgeInsets.only(right: 16.w),
            height: 24.h,
            width: 80.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32.r),
                color: AppColors.kcLightColor),
            child: Center(
              child: Text(
                "2.5 km",
                style: TextStyle(
                    color: AppColors.kcBackgroundColor,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        32.h.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
                child: CircleAvatar(
              backgroundColor: AppColors.kcGreen,
              radius: 22.r,
              child: Center(
                child: SvgPicture.asset('assets/icons/like_svg.svg'),
              ),
            )),
            16.w.horizontalSpace,
            Visibility(
                child: CircleAvatar(
              backgroundColor: AppColors.kcGreen,
              radius: 22.r,
              child: Center(
                child: SvgPicture.asset('assets/icons/heart_svg.svg'),
              ),
            )),
            16.w.horizontalSpace,
            Visibility(
                child: GestureDetector(
              onTap: () {
                context.read<ChatBloc>().add(
                    InitializeChat(targetUser: mainController.allUsers[index]));
              },
              child: CircleAvatar(
                backgroundColor: AppColors.kcGreen,
                radius: 22.r,
                child: Center(
                  child: SvgPicture.asset(
                    'assets/icons/message_svg.svg',
                    color: AppColors.kcBackgroundColor,
                  ),
                ),
              ),
            )),
            16.w.horizontalSpace,
            Visibility(
                child: CircleAvatar(
              backgroundColor: AppColors.kcGreen,
              radius: 22.r,
              child: Center(
                child: Text(
                  "FREE MESSAGE",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppColors.kcBackgroundColor,
                      fontSize: 8.sp,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )),
          ],
        ),
        SizedBox(
          height: size.height * 0.08,
        )
      ],
    );
  }
}
