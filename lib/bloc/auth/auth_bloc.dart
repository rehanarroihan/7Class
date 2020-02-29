import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:sevenclass/models/user_model.dart';
import 'package:sevenclass/services/user_service.dart';

import './bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  UserService _userService = UserService();

  bool registerPasswordObscure = true;
  bool isRegisterLoading = false;
  bool isEmailAlreadyRegistered = false;
  String previousRegisteredEmail = "";

  @override
  AuthState get initialState => InitialAuthState();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is RegisterPasswordObscureEvent) {
      yield* _registerPasswordObscure();
    } else if (event is DoRegisterEvent) {
      yield* _doRegister(event);
    } else if (event is ToggleEmailRegisteredEvent) {
      yield* _toggleEmailRegistered();
    }
  }

  Stream<AuthState> _registerPasswordObscure() async* {
    yield InitialAuthState();
    this.registerPasswordObscure = !registerPasswordObscure;
    yield RegisterPasswordObscureState();
  }

  // INFO : Send register request to server
  Stream<AuthState> _doRegister(DoRegisterEvent event) async* {
    this.isRegisterLoading = true;
    yield InitialAuthState();

    Map<String, dynamic> payload = {
      "email": event.email.trim(),
      "full_name": event.fullName.trim(),
      "password": event.password.trim(),
    };
    UserModel result = await _userService.doRegister(payload);

    this.isRegisterLoading = false;
    if (!result.success) {
      if (result.message == "Email already registered") {
        this.previousRegisteredEmail = event.email;
        this.isEmailAlreadyRegistered = true;
        yield EmailRegisteredState();
      } else {
        yield RegisterFailedState(message: result.message);
      }
    } else {
      yield RegisterResultState();
    }
  }

  Stream<AuthState> _toggleEmailRegistered() async* {
    yield InitialAuthState();
    this.isEmailAlreadyRegistered = !isEmailAlreadyRegistered;
  }
}
