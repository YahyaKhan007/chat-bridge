import 'dart:developer';

import 'package:chat_bridge/services/getx_controller/main_controller.dart';
import 'package:chat_bridge/services/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  Future<UserModel?> getUserbyUid(String uid) async {
    UserModel? userModel;
    log("===================================>>$uid");

    DocumentSnapshot docSnap =
        await FirebaseFirestore.instance.collection("users").doc(uid).get();

    if (docSnap.data() != null) {
      userModel = UserModel.fromJson(docSnap.data() as Map<String, dynamic>);

      log(userModel.fullName.toString());
    }

    return userModel;
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
}
