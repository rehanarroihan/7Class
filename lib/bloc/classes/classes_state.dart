import 'package:equatable/equatable.dart';

abstract class ClassesState extends Equatable {
  const ClassesState();

  @override
  List<Object> get props => [];
}

class InitialClassesState extends ClassesState {}

class IsCameraPermissionGrantedState extends ClassesState {}

class ClassCodeValidState extends ClassesState {}

class EnrollClassFailedState extends ClassesState {
  final String message;

  EnrollClassFailedState({this.message});
}

class EnrollClassNotFoundState extends ClassesState {}

class EnrollClassJoinedState extends ClassesState {}

class EnrollClassResultState extends ClassesState {}

class GetClassSuccessState extends ClassesState {}

class GetClassFailedState extends ClassesState {}
