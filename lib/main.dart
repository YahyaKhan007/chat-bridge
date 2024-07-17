import 'package:chat_bridge/bindings.dart';
import 'package:chat_bridge/blocs/auth_bloc/auth_bloc.dart';
import 'package:chat_bridge/blocs/edit_profile_bloc/edit_profile_bloc.dart';
import 'package:chat_bridge/blocs/onboarding_bloc/on_boarding_bloc.dart';
import 'package:chat_bridge/blocs/splash/splash_bloc.dart';
import 'package:chat_bridge/services/auth_service.dart/auth_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';

import 'firebase_options.dart';
import 'package:get/get.dart';

import 'services/routes/routes.dart';
import 'services/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GetStorage.init();
  final box = GetStorage();
  box.read('isFirstTime') ?? box.write('isFirstTime', true);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: ((context) => OnBoardingBloc())),
            BlocProvider(
              create: ((context) => SplashBloc(
                  authService: AuthService(), dbService: DataBaseService())),
            ),
            BlocProvider(
              create: ((context) => AuthBloc(
                    authService: AuthService(),
                    dbService: DataBaseService(),
                    snackBarService: SnackBarService(),
                  )),
            ),
            BlocProvider(
              create: ((context) =>
                  EditProfileBloc(PickerService(), DataBaseService())),
            ),
          ],
          child: GetMaterialApp(
            initialBinding: ControllerBinding(),
            debugShowCheckedModeBanner: false,
            initialRoute: RouterHelper.splash,
            getPages: RouterHelper.routes,
            navigatorKey: Get.key,
            title: 'Chat Bridge',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              textTheme: Typography.englishLike2018
                  .apply(fontSizeFactor: 1.sp, fontFamily: 'poppins'),
            ),
          ),
        );
      },
    );
  }
}
