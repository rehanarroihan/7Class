import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class EmailRegisteredEvent extends AuthEvent {
  final String email;

  EmailRegisteredEvent({
    this.email
  });

  @override
  String toString() => 'EmailRegisteredEvent';
}

class RegisterPasswordObscureEvent extends AuthEvent {
  @override
  String toString() => 'RegisterPasswordObscureEvent';
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

class ToggleEmailRegisteredEvent extends AuthEvent {
  @override
  String toString() => 'ToggleEmailRegisteredEvent';
}