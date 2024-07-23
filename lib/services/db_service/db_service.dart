import 'dart:developer';

import 'package:chat_bridge/models/chat_models/message_model/message_model.dart';
import 'package:chat_bridge/services/getx_controller/main_controller.dart';
import 'package:chat_bridge/services/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../models/models.dart';
import '../../views/utils/utils.dart';

class DataBaseService {
  FirebaseFirestore firestoreAuth = FirebaseFirestore.instance;

  // ^   Addng User to Firestore Database

  Future<bool> addUserToFireStore({required UserModel userData}) async {
    try {
      await firestoreAuth
          .collection('users')
          .doc(userData.uid)
          .set(userData.toJson());

      return true;
    } catch (e, stackTrace) {
      log('Error : ${e.toString()}\n\n');
      log('stackTrace : ${stackTrace.toString()}');

      return false;
    }
  }

// ^ getting user by uid
  Future<UserModel>? getUserbyUid(String uid) async {
    UserModel? userModel;
    log("===================================>>$uid");

    DocumentSnapshot docSnap =
        await FirebaseFirestore.instance.collection("users").doc(uid).get();

    if (docSnap.data() != null) {
      userModel = UserModel.fromJson(docSnap.data() as Map<String, dynamic>);

      log(userModel.fullName.toString());
    }

    return userModel!;
  }

  Future<bool> updateUserDetails(
      {required String country,
      required String city,
      required String nativeLanguage,
      required List<String> interestedLanguages,
      required String photo}) async {
    try {
      final mainControler = Get.find<ChatBridgeMainController>();

      UserModel userModel = mainControler.currentUserModel.value!;

      userModel.city = city;
      userModel.country = country;
      userModel.nativeLanguage = nativeLanguage;
      userModel.interestedLanguages = interestedLanguages;

      mainControler.currentUserModel.value = userModel;

      await firestoreAuth
          .collection('users')
          .doc(userModel.uid)
          .set(userModel.toJson())
          .then((value) => SnackBarService().showSnackbar(
              color: AppColors.kcGreen,
              message: "Pofile Updated",
              duration: 2,
              title: "Updated"));

      return true;
    } catch (e, stackTrace) {
      log("stackTrace : ${stackTrace.toString()}");
      return false;
    }
  }

  // getAllUsers() async {
  //   try {
  //     final mainController = Get.find<ChatBridgeMainController>();

  //     var snapshot = await firestoreAuth.collection('users').get();
  //     if (snapshot.docs.isNotEmpty) {
  //       for (var document in snapshot.docs) {
  //         var userMap = document.data();
  //         final user = UserModel.fromJson(userMap);
  //         mainController.allUsers.add(user);
  //       }
  //     }
  //   } catch (e, stackTrace) {
  //     log('stack trace   : $stackTrace');
  //   }
  // }

  Future<void> getAllUsers() async {
    try {
      // Ensure ChatBridgeMainController is registered with GetX
      final mainController = Get.find<ChatBridgeMainController>();

      // Reference to Firestore
      FirebaseFirestore firestoreAuth = FirebaseFirestore.instance;

      // Fetch the users collection snapshot
      QuerySnapshot snapshot = await firestoreAuth.collection('users').get();

      // Check if there are any documents
      if (snapshot.docs.isNotEmpty) {
        // Clear any existing users in the mainController
        mainController.allUsers.clear();

        // Iterate through each document and map to UserModel
        for (var document in snapshot.docs) {
          var userMap = document.data() as Map<String, dynamic>;
          final user = UserModel.fromJson(userMap);
          if (user.uid != FirebaseAuth.instance.currentUser!.uid) {
            mainController.allUsers.add(user);
          }
        }
      }
    } catch (e, stackTrace) {
      log('Error fetching users: $e');
      log('Stack trace: $stackTrace');
    }
  }

  Future<void> addMessageToFirestore(
      {required MessageModel newMessage,
      required ChatroomModel chatroom}) async {
    try {
      firestoreAuth
          .collection('chatrooms')
          .doc(chatroom.chatroomID)
          .collection('messages')
          .doc(newMessage.messageID)
          .set(
            newMessage.toJson(),
          )
          .then((value) {
        chatroom.updatedOn = Timestamp.now();
        chatroom.fromUser = newMessage.sender!;
        chatroom.lastMessage = newMessage.text!;

        return firestoreAuth
            .collection('chatrooms')
            .doc(chatroom.chatroomID)
            .update(chatroom.toJson());
      });
    } catch (e, stackTrace) {
      log("stackTrace : ${stackTrace.toString()}");
    }
  }

  Future<void> updateMessageInFirestore(
      {required MessageModel updatedMessage,
      required ChatroomModel chatroom}) async {}

Future<List<int>?> getAllUniqueNumbers() async {
    try {
      final docSnapshot =
          await firestoreAuth.collection('unique_numbers').doc('unique').get();

      if (docSnapshot.exists) {
        final data = docSnapshot.data();
        if (data != null && data['numbers'] != null) {
          return List<int>.from(data['numbers']);
        }
      }
    } catch (e, stackTrace) {
      log("Error getting unique numbers: $e");
      log("StackTrace: $stackTrace");
    }
    return null;
  }

  Future<void> pushUniqueNumberToFireStore() async {
    try {
      final uniqueNumber = Get.find<ChatBridgeMainController>().uniqueNumber.value;
      await firestoreAuth.collection('unique_numbers').doc('unique').set(
        {
          'numbers': FieldValue.arrayUnion([uniqueNumber]),
        },
        SetOptions(merge: true, ),
      );
        } catch (e, stackTrace) {
      log("Error pushing unique number: $e");
      log("StackTrace: $stackTrace");
    }
  }
}
