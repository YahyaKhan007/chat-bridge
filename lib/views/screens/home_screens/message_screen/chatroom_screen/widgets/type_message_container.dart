import 'package:chat_bridge/main.dart';
import 'package:chat_bridge/models/chat_models/chatroom_model/chatroom_model.dart';
import 'package:chat_bridge/models/chat_models/message_model/message_model.dart';
import 'package:chat_bridge/models/user_model/user_model.dart';
import 'package:chat_bridge/services/chat_service/chat_service.dart';
import 'package:chat_bridge/services/db_service/db_service.dart';
import 'package:chat_bridge/services/getx_controller/main_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../../models/models.dart';
import '../../../../../utils/utils.dart';

Widget typeMessageContainer(
    BuildContext context,
    Size size,
    TextEditingController messageController,
    UserModel targetUser,
    ChatroomModel chatModel) {
  return Container(
    height: size.height * 0.12,
    width: size.width,
    padding: EdgeInsets.only(left: 16.w, right: 0.w),
    decoration: const BoxDecoration(color: AppColors.kcBackgroundColor),
    child: Center(
      child: Row(
        children: [
          GestureDetector(
            onTap: () {},
            child: SvgPicture.asset('assets/icons/plus.svg'),
          ),
          8.w.horizontalSpace,
          Expanded(
              child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: const Color(0xffE9EAEB),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16).w,
              child: TextFormField(
                controller: messageController,
                style: TextStyle(fontSize: 12.sp, color: AppColors.kcDarkColor),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Type a message ...',
                  hintStyle:
                      TextStyle(fontSize: 12.sp, color: AppColors.kcLightColor),
                ),
              ),
            ),
          )),
          Padding(
            padding: const EdgeInsets.only(top: 8).h,
            child: GestureDetector(
              onTap: () async {
                await sendMessage(
                    message: messageController.text,
                    targetUser: targetUser,
                    chatroom: chatModel);

                messageController.clear();
              },
              child: SvgPicture.asset('assets/icons/send_svg.svg'),
            ),
          ),
        ],
      ),
    ),
  );
}

Future<void> sendMessage(
    {required String message,
    required UserModel targetUser,
    required ChatroomModel chatroom}) async {
  final mainController = Get.find<ChatBridgeMainController>();

  ChatService chatService = ChatService();

  MessageModel newMessage = MessageModel(
    image: null,
    isDelivered: false,
    isSeen: false,
    messageID: uuid.v4(),
    readTime: null,
    receiver: targetUser.uid,
    sender: mainController.currentUserModel.value!.uid,
    sentTime: Timestamp.now(),
    text: message,
    updatedOn: Timestamp.now(),
  );

  await chatService.sendMessage(message: newMessage, chatroom: chatroom);
}
