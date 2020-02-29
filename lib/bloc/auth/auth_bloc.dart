import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:sevenclass/models/user_model.dart';
import 'package:sevenclass/services/user_service.dart';

import './bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  UserService _userService = UserService();

  bool isRegisterLoading = false;

  @override
  AuthState get initialState => InitialAuthState();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is CheckEmailStatusEvent) {
      yield* _checkRegisteredEmail(event);
    } else if (event is DoRegisterEvent) {
      yield* _doRegister(event);
    }
  }

  // INFO : Check email
  Stream<AuthState> _checkRegisteredEmail(CheckEmailStatusEvent event) async*{
    yield InitialAuthState();

    Map<String, dynamic> payload = {
      "email": event.email
    };
    _userService.isEmailRegistered(payload);

    yield EmailCheckResultState();
  }

  // INFO : Send register request to server
  Stream<AuthState> _doRegister(DoRegisterEvent event) async*{
    this.isRegisterLoading = true;
    yield InitialAuthState();

    Map<String, dynamic> payload = {
      "email": event.email,
      "full_name": event.fullName,
      "password": event.password,
    };
    UserModel result = await _userService.doRegister(payload);
    this.isRegisterLoading = false;
    if (!result.success) {
      yield RegisterFailedState(message: result.message);
    } else {
      yield RegisterResultState();
    }

  }
}
