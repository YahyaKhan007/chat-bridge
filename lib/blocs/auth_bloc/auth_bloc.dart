import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:chat_bridge/services/auth_service.dart/auth_service.dart';
import 'package:chat_bridge/services/routes/routes.dart';
import 'package:chat_bridge/services/services.dart';
import 'package:chat_bridge/views/utils/app_colors.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../models/models.dart';
import '../../services/getx_controller/main_controller.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authService;
  final DataBaseService dbService;
  final SnackBarService snackBarService;
  AuthBloc({
    required this.authService,
    required this.dbService,
    required this.snackBarService,
  }) : super(const AuthState()) {
    on<GoogleSignInEvent>(_onGoogleSignIn);
    on<FacebookSignInEvent>(_onFacebookSignIn);
    on<TwitterSignInEvent>(_onTwitterSignIn);
    on<LoginEvent>(_loginUser);
    on<SignupEvent>(_signupUser);
    // on<SigninEvent>();
  }

  void _signupUser(SignupEvent event, Emitter<AuthState> emit) async {
    // emit(state.copyWith(isLoading: true));

    final mainController = Get.find<ChatBridgeMainController>();
    mainController.isLoading.value = true;

    log("Entered full name is ${event.fullName}");

    final signupDetails = await authService.signupUserWithEmailPassword(
        userEmail: event.email,
        userPassword: event.password,
        confirmPassword: event.confirmPassword,
        fullName: event.fullName);

    if (signupDetails.isSuccess == true) {
      mainController.isLoading.value = false;

      mainController.currentUserModel.value = signupDetails.userModel;

      Get.offAllNamed(RouterHelper.completeProfile);
    }
    mainController.isLoading.value = false;
  }

  void _loginUser(LoginEvent event, Emitter<AuthState> emit) async {
    final mainController = Get.find<ChatBridgeMainController>();
    try {
      mainController.isLoading.value = true;

      final user = await authService.loginUser(
          email: event.email, password: event.password);

      if (user.isSuccess == true) {
        mainController.currentUserModel.value = user.userModel;
        mainController.isLoading.value = true;
        getAllUsers();

        Get.offAllNamed(RouterHelper.dashboard);
      } else {
        mainController.isLoading.value = false;
      }
    } catch (e, stackTrace) {
      mainController.isLoading.value = true;

      log("stackTrace : ${stackTrace.toString()}");
    }
  }

// *  Google Sign in
  void _onGoogleSignIn(GoogleSignInEvent event, Emitter<AuthState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));
      final googleResponse = await authService.signInwithGoogle();

      if (googleResponse.res == true) {
        User? user = googleResponse.userCredential!.user;

        if (googleResponse.userCredential!.additionalUserInfo!.isNewUser) {
          UserModel newUser = UserModel(
              isVarified: true,
              city: '',
              country: '',
              interestedLanguages: [],
              nativeLanguage: '',
              uid: user!.uid,
              fullName: user.displayName!,
              emailAddress: user.email!,
              phoneNumber: '');
          var result = await dbService.addUserToFireStore(userData: newUser);
          if (result == true) {
            snackBarService.showSnackbar(
                color: AppColors.kcDarkColor,
                message: "You have been logged in",
                duration: 2,
                title: 'Welcome OnBoard');
            emit(state.copyWith(isLoading: false));
          } else {
            emit(state.copyWith(isLoading: false));
          }
        } else {
          final oldUser = await dbService.getUserbyUid(user!.uid);

          if (oldUser != null) {
            emit(state.copyWith(isLoading: false));
            snackBarService.showSnackbar(
                color: AppColors.kcDarkColor,
                message: "You have been logged in",
                duration: 2,
                title: 'Welcome Back');
          }
          emit(state.copyWith(isLoading: false));
        }
        Get.offAllNamed(RouterHelper.dashboard);
      } else {
        emit(state.copyWith(isLoading: false));
      }
    } catch (e, stackTrace) {
      log('stackTrace : ${stackTrace.toString()}');
    }
  }

// *  Facebook Sign in
  void _onFacebookSignIn(FacebookSignInEvent event, Emitter<AuthState> emit) {}

// *  Twitter Sign in
  void _onTwitterSignIn(TwitterSignInEvent event, Emitter<AuthState> emit) {}

  getAllUsers() async {
    dbService.getAllUsers();
  }
}
