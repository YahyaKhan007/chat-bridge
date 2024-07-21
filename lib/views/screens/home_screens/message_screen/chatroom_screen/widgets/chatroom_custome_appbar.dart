import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_bridge/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../utils/utils.dart';

PreferredSize customeAppbar(BuildContext context, UserModel targetUser) {
  Size size = MediaQuery.of(context).size;
  return PreferredSize(
      preferredSize: Size.fromHeight(96.h),
      child: Padding(
        padding: EdgeInsets.only(top: 24.h),
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 8).w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  GestureDetector(
                      onTap: () => Get.back(),
                      child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 20.r,
                          child:
                              SvgPicture.asset("assets/icons/arrow_back.svg"))),
                  SizedBox(
                    width: size.width * 0.26,
                  ),
                  Text(
                    'Message',
                    style: TextStyle(
                        color: AppColors.kcDarkColor,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              8.h.verticalHeight,
              ListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                horizontalTitleGap: 0,
                minVerticalPadding: 0,
                titleAlignment: ListTileTitleAlignment.center,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 20.r,
                      backgroundImage: const CachedNetworkImageProvider(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT6UC2VRLbRRbsduq3MX8aNLfUR5RweLFLRVJzxx6xvssNSeQYlanpHm_rf0cFD-sr0i4I&usqp=CAU'),
                    ),
                    8.w.horizontalSpace,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          targetUser.fullName,
                          style: TextStyle(
                              color: AppColors.kcDarkColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Active now',
                              style: TextStyle(
                                  color: AppColors.kcGreen,
                                  fontSize: 8.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ));
}
