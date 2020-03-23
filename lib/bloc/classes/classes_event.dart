import 'package:equatable/equatable.dart';

abstract class ClassesEvent extends Equatable {
  const ClassesEvent();

  @override
  List<Object> get props => [];
}

class IsCameraPermissionGrantedEvent extends ClassesEvent {

  @override
  String toString() => 'IsCameraPermissionGrantedEvent';
}

class RequestPermissionEvent extends ClassesEvent {

  @override
  String toString() => 'RequestPermissionEvent';
}

class ClassCodeValidEvent extends ClassesEvent {
  final bool isClassCodeValid;

  ClassCodeValidEvent({this.isClassCodeValid});

  @override
  String toString() => 'ClassCodeValidEvent';
}

class EnrollClassEvent extends ClassesEvent {
  final String classCode;

  EnrollClassEvent({this.classCode});

  @override
  String toString() => 'EnrollClassEvent';
}

class GetMyClassEvent extends ClassesEvent {

  @override
  String toString() => 'GetMyClassEvent';
}

class CreateNewClassEvent extends ClassesEvent {
  final String className;
  final String classDescription;

  CreateNewClassEvent({this.className, this.classDescription});

  @override
  String toString() => 'CreateNewClassEvent';
}

class TypeClassNameEvent extends ClassesEvent {
  final String className;

  TypeClassNameEvent({this.className});

  @override
  String toString() => 'TypeClassNameEvent';
}