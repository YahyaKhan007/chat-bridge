import 'package:chat_bridge/services/auth_service.dart/auth_service.dart';
import 'package:chat_bridge/views/screens/auth_screens/get_started/get_started.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../utils/utils.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: TextButton(
        onPressed: () async {
          await AuthService().signOutFromGoogle();
          Get.offAll(() => const GetStarted());
        },
        child: Text(
          'Logout',
          style: TextStyle(
              color: AppColors.kcDarkColor,
              fontSize: 30.sp,
              fontWeight: FontWeight.bold),
        ),
      )),
    );
  }
}
