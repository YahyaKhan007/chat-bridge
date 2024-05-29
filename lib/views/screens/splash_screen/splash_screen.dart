import 'package:chat_bridge/blocs/splash/splash_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    context.read<SplashBloc>().add(const SplashInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.kcBackgroundColor,
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Center(
          child: Text("Waiting...",
              style: TextStyle(
                  fontSize: 16.sp,
                  fontStyle: FontStyle.italic,
                  color: AppColors.kcLightColor,
                  fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
