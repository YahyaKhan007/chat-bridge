part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class GoogleSignInEvent extends AuthEvent {}

class FacebookSignInEvent extends AuthEvent {}

class TwitterSignInEvent extends AuthEvent {}
