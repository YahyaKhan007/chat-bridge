import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../blocs/edit_profile_bloc/edit_profile_bloc.dart';
import '../../../utils/utils.dart';

void showPhotoOption(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      Size size = MediaQuery.of(context).size;
      return Material(
        type: MaterialType.transparency,
        child: Center(
          child: Container(
            width: size.width * 0.85,
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
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.camera_alt),
                  title: const Text('Take a photo'),
                  onTap: () {
                    context
                        .read<EditProfileBloc>()
                        .add(const AddProfilePicEvent(key: 'camera'));

                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Choose from gallery'),
                  onTap: () {
                    context
                        .read<EditProfileBloc>()
                        .add(const AddProfilePicEvent(key: 'gallery'));

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
