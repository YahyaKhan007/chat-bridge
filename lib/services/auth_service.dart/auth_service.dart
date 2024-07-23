// ignore_for_file: use_build_context_synchronously, unused_local_variable

import 'dart:developer';
import 'package:chat_bridge/services/getx_controller/main_controller.dart';
import 'package:chat_bridge/views/utils/app_colors.dart';
import 'package:email_otp/email_otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../models/models.dart';
import '../services.dart';

class AuthService {
  FirebaseAuth auth = FirebaseAuth.instance;
  DataBaseService dbService = DataBaseService();
  SnackBarService snackBarService = SnackBarService();

  EmailOTP myOtp = EmailOTP();
  // EmailOtpService().getAuth();
  // EmailOtpService otpService = EmailOtpService();

  //

// ^ Signup User
  int _counter = 0;
  final int _maxCounterValue = 99999; // Adjust based on your needs

  int generateUniqueInteger() {
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    _counter = (_counter + 1) % _maxCounterValue;
    return int.parse('$timestamp$_counter');
  }

  Future<UserModel?> alreadyLoggedInUser() async {
    User? currentUser = auth.currentUser;
    if (currentUser != null) {
      var user = await dbService.getUserbyUid(currentUser.uid);
      return user;
    } else {
      return null;
    }
  }

  Future<({bool isSuccess, UserModel? userModel})> signupUserWithEmailPassword({
    required String userEmail,
    required String userPassword,
    required String confirmPassword,
    required String fullName,
  }) async {
    final mainController = Get.find<ChatBridgeMainController>();
    if (userEmail.isEmpty ||
        userPassword.isEmpty ||
        userPassword != confirmPassword) {
      snackBarService.showSnackbar(
          message: 'Please Enter Correct Credentials',
          duration: 2,
          color: Colors.red,
          title: "Wrong Credentials");
      return (isSuccess: false, userModel: null);
    } else {
      try {
        var userCredential = await auth.createUserWithEmailAndPassword(
            email: userEmail, password: userPassword);

        log(userCredential.user!.email.toString());

        User? user = userCredential.user;

        final allUniqueNumbers = await dbService.getAllUniqueNumbers();

        int newUniqueNumber;
        do {
          newUniqueNumber = generateUniqueInteger();
        } while (allUniqueNumbers != null &&
            allUniqueNumbers.contains(newUniqueNumber));

        mainController.uniqueNumber.value = newUniqueNumber;
        await dbService.pushUniqueNumberToFireStore();

        if (user != null) {
          UserModel newUserMode = UserModel(
              city: '',
              country: '',
              interestedLanguages: [],
              nativeLanguage: '',
              uid: userCredential.user!.uid,
              fullName: fullName,
              emailAddress: userEmail,
              phoneNumber: '',
              uniqueNumber: mainController.uniqueNumber.value,
              isVarified: true);

          var result =
              await DataBaseService().addUserToFireStore(userData: newUserMode);

          if (result == true) {
            snackBarService.showSnackbar(
                message: "Welcome to Inventory Object",
                duration: 3,
                color: AppColors.kcGreen,
                title: 'Signup Successful');
            return (isSuccess: true, userModel: newUserMode);
          }

          return (isSuccess: false, userModel: null);
        }
      } on FirebaseException catch (e) {
        snackBarService.showSnackbar(
            message: e.message.toString(),
            duration: 2,
            title: 'Signup Failed',
            color: Colors.red);
        return (isSuccess: false, userModel: null);
      } catch (e, stackTrace) {
        log('Error : ${e.toString()}');
        log('stackTrace : ${stackTrace.toString()}');
        return (isSuccess: false, userModel: null);
      }
    }
    return (isSuccess: false, userModel: null);
  }

// ^ Google Sign IN
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: [
    'email',
    'https://www.googleapis.com/auth/userinfo.profile',
  ], hostedDomain: 'gmail.com');

  Future<({bool res, UserCredential? userCredential})>
      signInwithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      final GoogleSignInAccount? currentUser = _googleSignIn.currentUser;

      if (currentUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await currentUser.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);

        User? user = userCredential.user;

        if (user != null) {
          return (res: true, userCredential: userCredential);
        }
        return (res: false, userCredential: null);
      }

      return (res: false, userCredential: null);
    } catch (e, stackTrace) {
      log('Error : ${e.toString()}\n\n');
      log('stackTrace : ${stackTrace.toString()}');
      return (res: false, userCredential: null);
    }
  }

  //  ^  Signout

  Future<void> signOutFromGoogle() async {
    await _googleSignIn.signOut();
    await auth.signOut();
  }

  // ^ Login with Email and Password

  Future<({bool isSuccess, UserModel? userModel})> loginUser({
    required String email,
    required String password,
  }) async {
    if (email.isEmpty || password.isEmpty) {
      snackBarService.showSnackbar(
        message: "Please Enter Correct Credentials",
        duration: 2,
        title: "Wrong Credentials",
        color: Colors.red,
      );
      return (isSuccess: false, userModel: null);
    } else {
      try {
        UserCredential userCredential = await auth.signInWithEmailAndPassword(
            email: email, password: password);

        User? currentUser = FirebaseAuth.instance.currentUser;

        if (currentUser != null) {
          String uid = userCredential.user!.uid;

          UserModel? currentUser = await dbService.getUserbyUid(uid);
          snackBarService.showSnackbar(
            message: "Welcome Back ${currentUser!.fullName}",
            duration: 2,
            title: "Login Successfull",
            color: Colors.green,
          );

          return (isSuccess: true, userModel: currentUser);
        } else {
          snackBarService.showSnackbar(
            message: "Please Enter Correct Credentials",
            duration: 2,
            title: "Wrong Credentials",
            color: Colors.red,
          );

          return (isSuccess: false, userModel: null);
        }
      } catch (e, stackTrace) {
        snackBarService.showSnackbar(
          message: e.toString(),
          duration: 2,
          title: "Wrong Credentials",
          color: Colors.red,
        );
        log('error : ${e.toString()}');
        log('stackTrace : ${stackTrace.toString()}');
        return (isSuccess: false, userModel: null);
      }
    }
  }
}
