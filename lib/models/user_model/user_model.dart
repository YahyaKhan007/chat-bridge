import 'dart:developer';

class UserModel {
  final String uid;
  final String fullName;
  final String emailAddress;
  final String phoneNumber;
  final bool isVarified;

  UserModel({
    required this.isVarified,
    required this.uid,
    required this.fullName,
    required this.emailAddress,
    required this.phoneNumber,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    log('Full Name : ${json['fullName']}');
    log('Phone Number : ${json['phoneNumber']}');
    log("Email Address : ${json['emailAddress']}");
    log(' uid : ${json['uid']}');
    return UserModel(
      uid: json['uid'],
      fullName: json['fullName'],
      isVarified: json['isVarified'],
      emailAddress: json['emailAddress'],
      phoneNumber: json['phoneNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'fullName': fullName,
      'isVarified': isVarified,
      'emailAddress': emailAddress,
      'phoneNumber': phoneNumber,
    };
  }
}
