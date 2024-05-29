import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/models.dart';

class DataBaseService {
  FirebaseFirestore firestoreAuth = FirebaseFirestore.instance;

  // ^   Addng User to Firestore Database

  Future<bool> addUserToFireStore({required UserModel userData}) async {
    try {
      log('ADDING USER TO FIREBASE DATABASE');
      log(' uid : ${userData.uid}');
      log(' fullName : ${userData.fullName}');
      log("isVarified : ${userData.isVarified}");
      log("email : ${userData.emailAddress}");

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
}
