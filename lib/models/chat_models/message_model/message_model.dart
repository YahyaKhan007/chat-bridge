import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String? messageID;
  String? sender;
  String? receiver;
  String? text;
  bool? isSeen;
  Timestamp? readTime;
  String? image;
  Timestamp? updatedOn;
  Timestamp? sentTime;
  bool? isDelivered;

  MessageModel({
    this.messageID,
    this.sender,
    this.receiver,
    this.text,
    this.isSeen,
    this.readTime,
    this.image,
    this.updatedOn,
    this.sentTime,
    this.isDelivered,
  });

  // Method to convert a JSON object to a MessageModel instance
  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      messageID: json['messageID'],
      sender: json['sender'],
      receiver: json['receiver'],
      text: json['text'],
      isSeen: json['isSeen'],
      readTime: json['readTime'] != null ? json['readTime'] as Timestamp : null,
      image: json['image'],
      updatedOn:
          json['updatedOn'] != null ? json['updatedOn'] as Timestamp : null,
      sentTime: json['sentTime'] != null ? json['sentTime'] as Timestamp : null,
      isDelivered: json['isDelivered'],
    );
  }

  // Method to convert a MessageModel instance to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'messageID': messageID,
      'sender': sender,
      'receiver': receiver,
      'text': text,
      'isSeen': isSeen,
      'readTime': readTime,
      'image': image,
      'updatedOn': updatedOn,
      'sentTime': sentTime,
      'isDelivered': isDelivered,
    };
  }
}
