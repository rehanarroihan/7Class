import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:sevenclass/app.dart';
import 'package:sevenclass/helpers/constant_helper.dart';
import 'package:sevenclass/models/login_model.dart';
import 'package:sevenclass/models/user_model.dart';
import 'package:sevenclass/services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  UserService _userService = UserService();

  bool registerPasswordObscure = true;
  bool isRegisterLoading = false;
  bool isEmailAlreadyRegistered = false;
  bool isAutoValidateOn = false;
  String previousRegisteredEmail = "";

  SharedPreferences _prefs = App().sharedPreferences;

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
    } else if (event is DoLoginEvent) {
      yield* _doLogin(event);
    } else if (event is LogoutEvent) {
      yield* _doLogout();
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

  // INFO : Send login request to server
  Stream<AuthState> _doLogin(DoLoginEvent event) async* {
    this.isRegisterLoading = true;
    yield InitialAuthState();

    Map<String, dynamic> payload = {
      "email": event.email.trim(),
      "password": event.password.trim(),
    };
    LoginModel result = await _userService.doLogin(payload);

    this.isRegisterLoading = false;
    if (!result.success) {
      yield RegisterFailedState(message: result.message);
    } else {
      // Save user detail to prefs
      _prefs.setBool(ConstantHelper.IS_USER_LOGGED_IN_PREF, true);
      _prefs.setString(ConstantHelper.USER_JWT_TOKEN_PREF, result.data.token);
      _prefs.setString(ConstantHelper.USER_ID_PREF, result.data.detail.id.toString());
      _prefs.setString(ConstantHelper.USER_EMAIL_PREF, result.data.detail.email);
      _prefs.setString(ConstantHelper.USER_FIRST_NAME_PREF, result.data.detail.firstName);
      _prefs.setString(ConstantHelper.USER_LAST_NAME_PREF, result.data.detail.lastName);
      yield RegisterResultState();
    }
  }

  Stream<AuthState> _doLogout() async* {
    yield InitialAuthState();
    _prefs.setBool(ConstantHelper.IS_USER_LOGGED_IN_PREF, false);
    _prefs.setString(ConstantHelper.USER_JWT_TOKEN_PREF, null);
    _prefs.setString(ConstantHelper.USER_ID_PREF, null);
    _prefs.setString(ConstantHelper.USER_EMAIL_PREF, null);
    _prefs.setString(ConstantHelper.USER_FIRST_NAME_PREF, null);
    _prefs.setString(ConstantHelper.USER_LAST_NAME_PREF, null);
    yield LogoutState();
  }
}
