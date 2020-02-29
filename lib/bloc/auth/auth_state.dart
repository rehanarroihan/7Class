import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class InitialAuthState extends AuthState {}

class DoRegisterState extends AuthState {
  @override
  String toString() => 'DoRegisterState';
}

class RegisterResultState extends AuthState {


  @override
  String toString() => 'RegisterResultState';
}

class EmailCheckState extends AuthState {}

class EmailCheckResultState extends AuthState {}

class RegisterFailedState extends AuthState {
  final String message;

  RegisterFailedState({this.message});
}