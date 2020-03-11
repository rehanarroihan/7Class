import 'package:equatable/equatable.dart';

abstract class ClassesState extends Equatable {
  const ClassesState();

  @override
  List<Object> get props => [];
}

class InitialClassesState extends ClassesState {}

class IsCameraPermissionGrantedState extends ClassesState {}
