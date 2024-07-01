import 'package:chat_bridge/views/screens/views.dart';
import 'package:get/get.dart';

class RouterHelper {
  static const String splash = '/splash';
  static const String onboarding = '/onboarding';
  static const String getStarted = '/getStarted';
  static const String dashboard = '/dashboard';

  static const String login = '/login';
  static const String register = '/register';

  static List<GetPage> routes = [
    GetPage(name: splash, page: () => const SplashScreen()),
    GetPage(name: onboarding, page: () => const OnBoardingScreen()),
    GetPage(name: login, page: () => const LoginPage()),
    GetPage(name: getStarted, page: () => const GetStarted()),
    GetPage(name: dashboard, page: () => const DashboardScreen()),
    GetPage(name: register, page: () => const RegistrationScreen()),
  ];
}
