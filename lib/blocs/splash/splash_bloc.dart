import 'package:bloc/bloc.dart';
import 'package:chat_bridge/services/auth_service.dart/auth_service.dart';
import 'package:chat_bridge/services/getx_controller/main_controller.dart';
import 'package:chat_bridge/services/routes/routes.dart';
import 'package:chat_bridge/services/services.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../models/models.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final AuthService authService;
  final DataBaseService dbService;
  SplashBloc({
    required this.authService,
    required this.dbService,
  }) : super(const SplashState()) {
    on<SplashInitialEvent>(_splashInitial);
  }

  // * Splash Initial Event
  void _splashInitial(
      SplashInitialEvent event, Emitter<SplashState> emit) async {
    final box = GetStorage();
    final isFirstTime = box.read('isFirstTime');
    final mainController = Get.find<ChatBridgeMainController>();

    await Future.delayed(const Duration(seconds: 2));

    if (isFirstTime == true) {
      Get.offAllNamed(RouterHelper.onboarding);
    } else {
      mainController.currentUserModel.value = null;
      if (authService.auth.currentUser == null) {
        emit(state.copyWith(currentUser: null));
        Get.offAllNamed(RouterHelper.getStarted);
      } else {
        final currentUser =
            await dbService.getUserbyUid(authService.auth.currentUser!.uid);
        mainController.currentUserModel.value = currentUser;
        emit(state.copyWith(currentUser: currentUser));
        if (currentUser!.country != '') {
          Get.offAllNamed(RouterHelper.completeProfile);
        } else {
          Get.offAllNamed(RouterHelper.dashboard);
        }
      }
    }
  }
}
