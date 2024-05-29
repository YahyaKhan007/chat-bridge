// ignore_for_file: use_build_context_synchronously, unused_local_variable

import 'dart:developer';
import 'package:email_otp/email_otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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

  Future<UserModel?> alreadyLoggedInUser() async {
    User? currentUser = auth.currentUser;
    if (currentUser != null) {
      var user = await dbService.getUserbyUid(currentUser.uid);
      return user;
    } else {
      return null;
    }
  }

// ^ Signup User
  Future<bool> signupUserWithEmailPassword({
    required String userEmail,
    required String userPassword,
    required String confirmPassword,
    required bool isOtpApproved,
  }) async {
    log('came 1 to signup  ');
    if (userEmail.isEmpty ||
        userPassword.isEmpty ||
        userPassword != confirmPassword) {
      snackBarService.showSnackbar(
          message: 'Please Enter Correct Credentials',
          duration: 2,
          title: "Wrong Credentials");
      return false;
    } else {
      try {
        // * Otp Not  approved

        if (!isOtpApproved) {
          log("Hello  GGggg   OTP not approved");
          myOtp.setConfig(
              appEmail: "me@rohitchouhan.com",
              appName: "Email OTP",
              userEmail: userEmail,
              otpLength: 4,
              otpType: OTPType.digitsOnly);

          if (await myOtp.sendOTP() == true) {
            snackBarService.showSnackbar(
                message: "OTP has been sent to your email",
                duration: 2,
                title: "OTP sent",
                color: Colors.green);

            // Get.to(() => OTPScreen(
            //       confirmPassword: confirmPassword,
            //       password: userPassword,
            //       email: userEmail,
            //       myAuth: myOtp,
            //     ));

            return true;
          } else {
            snackBarService.showSnackbar(
                message: "OTP Failed",
                duration: 2,
                title: "OTP sending failed",
                color: Colors.red);
            return false;
          }
        }
        // * Otp  approved
        else {
          log("Hello  GGggg   OTP  approved");

          var userCredential = await auth.createUserWithEmailAndPassword(
              email: userEmail, password: userPassword);
          log('came 2 to signup  ');

          log(userCredential.user!.email.toString());

          User? user = userCredential.user;
          log('came 3 to signup  ');

          if (user != null) {
            UserModel newUserMode = UserModel(
                uid: userCredential.user!.uid,
                fullName: '',
                emailAddress: userEmail,
                phoneNumber: '',
                isVarified: true);
            log('came 4 to signup  ');

            var result = await DataBaseService()
                .addUserToFireStore(userData: newUserMode);

            log('came 5 to signup  ');

            if (result == true) {
              snackBarService.showSnackbar(
                  message: "Welcome to Inventory Object",
                  duration: 3,
                  title: 'Signup Successful');
              return true;
            }
          }

          return false;
        }
      } on FirebaseException catch (e) {
        snackBarService.showSnackbar(
            message: e.message.toString(),
            duration: 2,
            title: 'Signup Failed',
            color: Colors.red);
        return false;
      } catch (e, stackTrace) {
        log('Error : ${e.toString()}\n\n');
        log('stackTrace : ${stackTrace.toString()}');
        return false;
      }
    }
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
        log("came to Login");
        UserCredential userCredential = await auth.signInWithEmailAndPassword(
            email: email, password: password);

        String uid = userCredential.user!.uid;

        User? currentUser = FirebaseAuth.instance.currentUser;

        if (currentUser != null) {
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
