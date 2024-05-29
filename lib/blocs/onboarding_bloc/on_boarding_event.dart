part of 'on_boarding_bloc.dart';

sealed class OnBoardingEvent extends Equatable {
  const OnBoardingEvent();

  @override
  List<Object> get props => [];
}

class ChangePageEvent extends OnBoardingEvent {
  final int index;
  const ChangePageEvent({required this.index});
}
