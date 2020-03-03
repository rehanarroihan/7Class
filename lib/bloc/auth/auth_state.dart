import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class InitialAuthState extends AuthState {}

class DoRegisterState extends AuthState {}

class RegisterResultState extends AuthState {}

class RegisterPasswordObscureState extends AuthState {}

class EmailCheckResultState extends AuthState {}

class EmailRegisteredState extends AuthState {}

class RegisterFailedState extends AuthState {
  final String message;

  RegisterFailedState({this.message});
}

class ToggleEmailRegisteredState extends AuthState {}

class LogoutState extends AuthState {}