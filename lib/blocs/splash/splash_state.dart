part of 'splash_bloc.dart';

class SplashState extends Equatable {
  final UserModel? currentUser;
  const SplashState({this.currentUser});

  SplashState copyWith({UserModel? currentUser}) {
    return SplashState(currentUser: currentUser);
  }

  @override
  List<Object?> get props => [currentUser];
}
