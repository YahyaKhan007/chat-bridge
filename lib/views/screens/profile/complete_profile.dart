import 'dart:developer';

import 'package:chat_bridge/blocs/edit_profile_bloc/edit_profile_bloc.dart';
import 'package:chat_bridge/views/screens/auth_screens/registeration.dart/email_pass_column.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../blocs/splash/splash_bloc.dart';
import '../../utils/utils.dart';
import '../../widgets/custome_button.dart';
import 'widgets/pic_avatar.dart';
import 'widgets/pick_image.dart';
import 'widgets/select_interested_language.dart';
import 'widgets/show_interested_languages.dart';

class CompleteProfile extends StatelessWidget {
  CompleteProfile({super.key});

  final TextEditingController interestController = TextEditingController();
  final FocusNode interestFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.kcBackgroundColor,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16).w,
          child: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Container(
              height: 40.h,
              width: 40.w,
              decoration: BoxDecoration(
                color: AppColors.kcLightColor.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child:
                  const Icon(CupertinoIcons.back, color: AppColors.kcDarkColor),
            ),
          ),
        ),
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16).w,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          log('Profile Tapped');
                        },
                        child: Text(
                          "Profile",
                          style: TextStyle(
                            fontSize: 30.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.kcDarkColor,
                          ),
                        ),
                      ),
                      24.h.verticalHeight,
                      GestureDetector(
                        onTap: () => showPhotoOption(context),
                        child: picAvatar(size: size),
                      ),
                      8.h.verticalHeight,
                      BlocBuilder<SplashBloc, SplashState>(
                        builder: (context, state) {
                          return Text(
                            state.currentUser?.fullName ?? 'Unknown',
                            style: TextStyle(
                              color: AppColors.kcDarkColor,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        },
                      ),
                      16.h.verticalHeight,
                      fieldColumn(
                        size: size,
                        key: 'Country',
                        hintText: 'Enter your Country name',
                      ),
                      16.h.verticalHeight,
                      fieldColumn(
                        size: size,
                        key: 'City',
                        hintText: 'Enter your City name',
                      ),
                      16.h.verticalHeight,
                      fieldColumn(
                        size: size,
                        key: 'Native Language',
                        hintText: "Enter Native Language",
                      ),
                      16.h.verticalHeight,
                      selectInterest(
                        size: size,
                        controller: interestController,
                        interestFocus: interestFocus,
                      ),
                      16.h.verticalHeight,
                      showInterestedlanguages(),
                      16.h.verticalHeight,
                    ],
                  ),
                ),
              ),
            ),
            16.h.verticalHeight,
            Column(
              children: [
                customeButton(
                  isCenter: true,
                  buttonText: "Confirm",
                  textColor: AppColors.kcBackgroundColor,
                  fontWeight: FontWeight.w600,
                  onTap: () {
                    context.read<EditProfileBloc>().add(const UpdateUserDetails(
                          city: '',
                          country: '',
                          interestedLanguages: [],
                          nativeLanguage: '',
                        ));
                  },
                  circularRadius: 30.r,
                ),
                16.h.verticalHeight,
                // termsAndConditions(size: size),
                // 32.h.verticalHeight,
              ],
            ),
          ],
        ),
      ),
    );
  }

  void showPhotoOption(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Material(
          type: MaterialType.transparency,
          child: Center(
            child: Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: AppColors.kcBackgroundColor,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Choose an option',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.kcDarkColor,
                    ),
                  ),
                  16.h.verticalHeight,
                  ListTile(
                    leading: Icon(Icons.camera_alt),
                    title: Text('Take a photo'),
                    onTap: () {
                      // Add your take photo logic here
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.photo_library),
                    title: Text('Choose from gallery'),
                    onTap: () {
                      // Add your choose from gallery logic here
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
