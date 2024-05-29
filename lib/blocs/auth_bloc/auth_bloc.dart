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
    on<GoogleSignInEvent>(onGoogleSignIn);
    on<FacebookSignInEvent>(onFacebookSignIn);
    on<TwitterSignInEvent>(onTwitterSignIn);
    // on<SignupEvent>();
    // on<SigninEvent>();
  }

// *  Google Sign in
  void onGoogleSignIn(GoogleSignInEvent event, Emitter<AuthState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));
      final googleResponse = await authService.signInwithGoogle();

      if (googleResponse.res == true) {
        User? user = googleResponse.userCredential!.user;

        if (googleResponse.userCredential!.additionalUserInfo!.isNewUser) {
          UserModel newUser = UserModel(
              isVarified: true,
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
  void onFacebookSignIn(FacebookSignInEvent event, Emitter<AuthState> emit) {}

// *  Twitter Sign in
  void onTwitterSignIn(TwitterSignInEvent event, Emitter<AuthState> emit) {}
}
