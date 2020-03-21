import 'dart:async';

import 'package:bloc/bloc.dart';

import './bloc.dart';

enum SectionActive { OVERVIEW, PRIVATE, CLASSES, TASK, PROFILE }

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  SectionActive sectionActive = SectionActive.OVERVIEW;

  @override
  HomeState get initialState => InitialHomeState();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event,) async* {
    if (event is ChangeSectionEvent) {
      yield InitialHomeState();
      this.sectionActive = event.sectionActive;
      yield SectionChangedState();
    }
  }
}
