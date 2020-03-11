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