// ignore_for_file: must_be_immutable

import 'dart:developer';
import 'package:chat_bridge/views/utils/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../models/models.dart';
import '../../../../../services/getx_controller/main_controller.dart';
import '../../../../widgets/widgets.dart';
import 'widgets/chatroom_custome_appbar.dart';
import 'widgets/type_message_container.dart';

class ChatroomScreen extends StatelessWidget {
  final ChatroomModel chatModel;
  final UserModel targetUser;

  ChatroomScreen(
      {super.key, required this.chatModel, required this.targetUser});

  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ChatBridgeMainController mainController =
        Get.find<ChatBridgeMainController>();

    return Scaffold(
      appBar: customeAppbar(context, targetUser),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('chatrooms')
                    .doc(chatModel.chatroomID)
                    .collection('messages')
                    .orderBy("updatedOn", descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: loadingWidgetInkDrop(
                          color: AppColors.kcDarkColor, size: 50),
                    );
                  }
                  log(snapshot.data!.docs.length.toString());

                  if (snapshot.data == null) {
                    return Center(
                        child: loadingWidgetInkDrop(
                            size: 16.r, color: AppColors.kcDarkColor));
                  }

                  if (snapshot.data!.docs.isEmpty) {
                    return Center(
                      child: Text(
                        "Say hi to start a conversation!",
                        style: TextStyle(
                            fontSize: 12.sp, color: AppColors.kcDarkColor),
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    itemCount: snapshot.data!.docs.length,
                    reverse: true,
                    itemBuilder: ((context, index) {
                      Map<String, dynamic> mapData =
                          snapshot.data!.docs[index].data();

                      var message = MessageModel.fromJson(mapData);

                      if (message.sender ==
                          mainController.currentUserModel.value!.uid) {
                        return sendMessages(message: message);
                      } else {
                        return recievedMessages(message: message);
                      }
                    }),
                  );
                },
              ),
            ),
            typeMessageContainer(
                context, size, messageController, targetUser, chatModel),
          ],
        ),
      ),
    );
  }

  Widget sendMessages({required MessageModel message}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8).h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
            decoration: BoxDecoration(
              color: AppColors.kcGreen,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.r),
                  topRight: Radius.circular(16.r),
                  bottomLeft: Radius.circular(16.r)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  message.text.toString(),
                  style: TextStyle(
                      color: AppColors.kcBackgroundColor, fontSize: 12.sp),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget recievedMessages({required MessageModel message}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8).h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
            decoration: BoxDecoration(
              color: AppColors.kcBackgroundColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.r),
                  topRight: Radius.circular(16.r),
                  bottomRight: Radius.circular(16.r)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  message.text.toString(),
                  style:
                      TextStyle(color: AppColors.kcDarkColor, fontSize: 12.sp),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
