part of 'on_boarding_bloc.dart';

class OnBoardingState extends Equatable {
  final PageController pageController;
  final int currentPage;
  OnBoardingState({PageController? pageController, this.currentPage = 0})
      : pageController = pageController ?? PageController();

  OnBoardingState copyWith({int? currentPage}) {
    return OnBoardingState(
        pageController: pageController,
        currentPage: currentPage ?? this.currentPage);
  }

  @override
  List<Object> get props => [currentPage, pageController];
}
