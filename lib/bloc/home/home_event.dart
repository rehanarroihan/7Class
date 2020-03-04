import 'package:equatable/equatable.dart';
import 'package:sevenclass/bloc/home/bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class ChangeSectionEvent extends HomeEvent {
  final SectionActive sectionActive;

  ChangeSectionEvent({this.sectionActive});

  @override
  String toString() => 'ChangeSectionEvent';
}