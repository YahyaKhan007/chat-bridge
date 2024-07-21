import 'dart:developer';

import 'package:chat_bridge/models/chat_models/chatroom_model/chatroom_model.dart';
import 'package:chat_bridge/models/chat_models/message_model/message_model.dart';
import 'package:chat_bridge/services/db_service/db_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../main.dart';
import '../../models/models.dart';
import '../getx_controller/main_controller.dart';

class ChatService {
  final dbService = DataBaseService();
  final mainController = Get.find<ChatBridgeMainController>();

  Future<ChatroomModel?> getChatroomModel({
    required UserModel targetUser,
    required UserModel userModel,
  }) async {
    ChatroomModel? chatRoom;
    // Loading.showLoadingDialog(context, "Creating");
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection("chatrooms")
        .where("participants.${userModel.uid}", isEqualTo: true)
        .where("participants.${targetUser.uid}", isEqualTo: true)
        .get();

    if (snapshot.docs.isNotEmpty) {
      var docData = snapshot.docs[0].data();

      ChatroomModel existingChatRoom =
          ChatroomModel.fromJson(docData as Map<String, dynamic>);

      chatRoom = existingChatRoom;

      log("Already Existed");
    } else {
      // Loading.showLoadingDialog(context, "Creatin,g");

      ChatroomModel newChatRoom = ChatroomModel(
          users: [
            mainController.currentUserModel.value!.uid.toString(),
            targetUser.uid.toString()
          ],
          createdOn: Timestamp.now(),
          chatroomID: uuid.v1(),
          lastMessage: "Say hi! to start a conversation.",
          isRead: false,
          fromUser: userModel.uid.toString(),
          delivered: false,
          participants: {
            userModel.uid.toString(): true,
            targetUser.uid.toString(): true
          },
          // users: [userModel.uid.toString(), targetUser.uid.toString()],
          updatedOn: Timestamp.now());

      await FirebaseFirestore.instance
          .collection("chatrooms")
          .doc(newChatRoom.chatroomID)
          .set(newChatRoom.toJson());

      chatRoom = newChatRoom;

      log("New Charoom Created");
    }
    return chatRoom;
  }

  Future<void> sendMessage(
      {required MessageModel message, required ChatroomModel chatroom}) async {
    await dbService.addMessageToFirestore(
        newMessage: message, chatroom: chatroom);
  }
}
