import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'on_boarding_event.dart';
part 'on_boarding_state.dart';

class OnBoardingBloc extends Bloc<OnBoardingEvent, OnBoardingState> {
  OnBoardingBloc() : super(OnBoardingState()) {
    on<ChangePageEvent>(_changePage);
  }

  // * Change Page Event
  void _changePage(ChangePageEvent event, Emitter<OnBoardingState> emit) {
    emit(state.copyWith(currentPage: event.index));
    if (state.pageController.hasClients) {
      state.pageController.animateToPage(event.index,
          duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    }
  }
}
