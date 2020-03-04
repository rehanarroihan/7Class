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

class SaveWrittenAuthDataEvent extends AuthEvent {
  final String email;
  final String password;
  final String fullName;

  SaveWrittenAuthDataEvent({
    this.email,
    this.password,
    this.fullName = ""
  });

  @override
  String toString() => 'SaveWrittenAuthData';
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

class DoLoginEvent extends AuthEvent {
  final String email;
  final String password;

  DoLoginEvent({
    this.email,
    this.password
  });

  @override
  String toString() => 'DoLoginEvent';
}

class LogoutEvent extends AuthEvent {
  @override
  String toString() => 'LogoutEvent';
}

class AutoValidateOnEvent extends AuthEvent {
  @override
  String toString() => 'AutoValidateOnEvent';
}

class LoginAutoValidateOnEvent extends AuthEvent {
  @override
  String toString() => 'LoginAutoValidateOnEvent ';
}