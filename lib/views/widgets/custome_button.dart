import 'package:chat_bridge/blocs/auth_bloc/auth_bloc.dart';
import 'package:chat_bridge/services/getx_controller/main_controller.dart';
import 'package:chat_bridge/views/utils/app_colors.dart';
import 'package:chat_bridge/views/widgets/loading_widget/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Widget customeButton({
  Color? backgroundColor,
  Color? textColor,
  double? textSize,
  String? buttonText,
  double? buttonSize,
  double? circularRadius,
  double? buttonHeight,
  FontWeight? fontWeight,
  bool? isCenter,
  VoidCallback? onTap,
}) {
  final mainController = Get.find<ChatBridgeMainController>();

  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: buttonHeight ?? 50,
      width: buttonSize ?? 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(circularRadius ?? 10),
        color: backgroundColor ?? AppColors.kcDarkColor,
      ),
      child: Obx(
        () => Center(
          child: mainController.isLoading.value
              ? loadingWidgetInkDrop(
                  size: 20.r,
                  color: AppColors.kcBackgroundColor,
                )
              : Text(
                  buttonText ?? "No Button Text",
                  style: TextStyle(
                    fontStyle: FontStyle.normal,
                    fontSize: textSize ?? 12.sp,
                    color: textColor ?? AppColors.kcLightColor,
                    fontWeight: fontWeight ?? FontWeight.normal,
                  ),
                  textAlign:
                      isCenter == true ? TextAlign.center : TextAlign.left,
                ),
        ),
      ),
    ),
  );
}
