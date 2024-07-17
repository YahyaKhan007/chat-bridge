import 'package:chat_bridge/blocs/auth_bloc/auth_bloc.dart';
import 'package:chat_bridge/views/utils/app_colors.dart';
import 'package:chat_bridge/views/widgets/loading_widget/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget customeButton(
    {Color? backgroundColor,
    Color? textColor,
    double? textSize,
    String? buttonText,
    double? buttonSize,
    double? circularRadius,
    double? buttonHeight,
    FontWeight? fontWeight,
    bool? isCenter,
    VoidCallback? onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Container(
          height: 50,
          width: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(circularRadius ?? 10),
            color: backgroundColor ?? AppColors.kcDarkColor,
          ),
          child: isCenter != null && isCenter == true
              ? Center(
                  child: Text(
                    buttonText ?? "No Button Text",
                    style: TextStyle(
                      fontStyle: FontStyle.normal,
                      fontSize: textSize ?? 12.sp,
                      color: textColor ?? AppColors.kcLightColor,
                      fontWeight: fontWeight ?? FontWeight.normal,
                    ),
                  ),
                )
              : state.isLoading == true
                  ? loadingWidgetInkDrop(
                      size: 20.r, color: AppColors.kcBackgroundColor)
                  : Text(
                      buttonText ?? "No Button Text",
                      style: TextStyle(
                        fontStyle: FontStyle.normal,
                        fontSize: textSize ?? 12.sp,
                        color: textColor ?? AppColors.kcLightColor,
                        fontWeight: fontWeight ?? FontWeight.normal,
                      ),
                    ),
        );
      },
    ),
  );
}
