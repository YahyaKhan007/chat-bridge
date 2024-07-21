import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_bridge/models/chat_models/chatroom_model/chatroom_model.dart';
import 'package:chat_bridge/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../../services/getx_controller/main_controller.dart';
import '../../../../../utils/utils.dart';

Widget chatTile(
    {required ChatroomModel chatroom, required UserModel targetUser}) {
  ChatBridgeMainController mainController =
      Get.find<ChatBridgeMainController>();
  return ListTile(
    leading: CircleAvatar(
      radius: 20.r,
      backgroundImage: const CachedNetworkImageProvider(
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT6UC2VRLbRRbsduq3MX8aNLfUR5RweLFLRVJzxx6xvssNSeQYlanpHm_rf0cFD-sr0i4I&usqp=CAU'),
    ),
    titleAlignment: ListTileTitleAlignment.center,
    title: Text(
      targetUser.fullName,
      style: TextStyle(
          color: AppColors.kcDarkColor,
          fontSize: 14.sp,
          fontWeight: FontWeight.bold),
    ),
    subtitle: Text(
      chatroom.lastMessage,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          color: AppColors.kcDarkColor,
          fontSize: 12.sp,
          fontWeight: FontWeight.normal),
    ),
    trailing: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "10:25 AM",
          style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.w300,
              color: AppColors.kcLightColor),
        ),
        8.h.verticalSpace,
        Container(
          decoration: BoxDecoration(
              color: AppColors.kcGreen,
              borderRadius: BorderRadius.circular(4.r)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 2),
            child: Text(
              "2",
              style: TextStyle(
                color: AppColors.kcBackgroundColor,
                fontSize: 10.sp,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
