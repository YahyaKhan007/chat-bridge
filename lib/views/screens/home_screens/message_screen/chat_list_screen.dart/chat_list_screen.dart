import 'package:chat_bridge/services/getx_controller/main_controller.dart';
import 'package:chat_bridge/services/services.dart';
import 'package:chat_bridge/views/screens/home_screens/message_screen/chatroom_screen/chatroom_screen.dart';
import 'package:chat_bridge/views/widgets/loading_widget/loading_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../models/models.dart';
import '../../../../utils/utils.dart';
import 'widgets/chat_tile.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final mainController = Get.find<ChatBridgeMainController>();

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.h),
          child: Padding(
            padding: EdgeInsets.only(top: 24.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // IconButton(onPressed: () {}, icon: Icon(BoxIcons.bx_message))
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Iconsax.message_2_bulk,
                      color: AppColors.kcGreen,
                    )),
                Text(
                  'Chat',
                  style: TextStyle(
                      color: AppColors.kcDarkColor,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: size.width * 0.12,
                ),
              ],
            ),
          )),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('chatrooms')
              .where('users',
                  arrayContains: mainController.currentUserModel.value!.uid)
              .orderBy('updatedOn', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: loadingWidgetInkDrop(
                    color: AppColors.kcDarkColor, size: 30.r),
              );
            }

            if (snapshot.data == null) {
              return Center(
                child: Text(
                  "No Chats yet",
                  style: TextStyle(fontSize: 30.sp),
                ),
              );
            }

            if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.only(bottom: size.height * 0.15).h,
                  child: Text(
                    "No Initialized Chats",
                    style: TextStyle(
                        fontSize: 14.sp, color: AppColors.kcDarkColor),
                  ),
                ),
              );
            }

            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> docData =
                    snapshot.data!.docs[index].data();
                final chatroom = ChatroomModel.fromJson(docData);

                List<dynamic> users = chatroom.participants!.keys.toList();
                users.remove(mainController.currentUserModel.value!.uid);

                String targetUserId = users[0];

                return FutureBuilder<UserModel>(
                  future: DataBaseService().getUserbyUid(targetUserId),
                  builder: (context, userSnapshot) {
                    if (userSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return SizedBox(
                        height: 56.h,
                        width: size.width,
                        child: Shimmer.fromColors(
                          period: const Duration(seconds: 2),
                          baseColor: AppColors.kcLightColor.withOpacity(0.2),
                          highlightColor: AppColors.kcLightColor,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius: 20.r,
                                ),
                                16.w.horizontalSpace,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: size.width *
                                          0.7, // Adjust the width as needed
                                      height: 16.h,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(height: 8.h),
                                    Container(
                                      width: size.width *
                                          0.3, // Adjust the width as needed
                                      height: 8.h,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }

                    if (userSnapshot.hasData) {
                      return GestureDetector(
                        onTap: () {
                          Get.to(() => ChatroomScreen(
                                chatModel: chatroom,
                                targetUser: userSnapshot.data!,
                              ));
                        },
                        child: chatTile(
                          chatroom: chatroom,
                          targetUser: userSnapshot.data!,
                        ),
                      );
                    }

                    return const Center(
                        child: Text('Error fetching user data'));
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
