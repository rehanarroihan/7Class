import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class CheckEmailStatusEvent extends AuthEvent {
  final String email;

  CheckEmailStatusEvent(this.email);

  @override
  String toString() => 'CheckEmailStatusEvent';
}

class DoRegisterEvent extends AuthEvent {
  final String email;
  final String password;
  final String fullName;

  DoRegisterEvent({
    this.email,
    this.password,
    this.fullName
  });

  @override
  String toString() => 'DoRegisterEvent';
}