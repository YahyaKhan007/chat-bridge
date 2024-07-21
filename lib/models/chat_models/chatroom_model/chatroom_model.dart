import 'package:cloud_firestore/cloud_firestore.dart';

class ChatroomModel {
  String chatroomID;
  String fromUser;
  String lastMessage;
  Timestamp createdOn;
  Timestamp updatedOn;
  bool isRead;
  bool delivered;
  List<dynamic>? users;
  Map<String, dynamic>?
      participants; // Additional property to store participants

  ChatroomModel({
    required this.chatroomID,
    required this.fromUser,
    required this.lastMessage,
    required this.createdOn,
    required this.updatedOn,
    required this.isRead,
    required this.delivered,
    required this.users,
    required this.participants,
  });

  // Method to convert a JSON object to a ChatroomModel instance
  factory ChatroomModel.fromJson(Map<String, dynamic> json) {
    return ChatroomModel(
      chatroomID: json['chatroomID'],
      fromUser: json['fromUser'],
      lastMessage: json['lastMessage'],
      createdOn: json['createdOn'],
      updatedOn: json['updatedOn'],
      isRead: json['isRead'],
      delivered: json['delivered'],
      users: json['users'],
      participants: json['participants'],
    );
  }

  // Method to convert a ChatroomModel instance to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'chatroomID': chatroomID,
      'fromUser': fromUser,
      'lastMessage': lastMessage,
      'createdOn': createdOn,
      'updatedOn': updatedOn,
      'isRead': isRead,
      'delivered': delivered,
      'users': users,
      'participants': participants,
    };
  }
}
