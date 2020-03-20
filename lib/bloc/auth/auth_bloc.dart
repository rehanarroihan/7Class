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
  bool isRegisterAutoValidateOn = false;
  String previousRegisteredEmail = "";

  bool isLoginLoading = false;
  bool isLoginAutoValidateOn = false;

  Map<String, dynamic> writtenAuthData = {
    "email": "",
    "password": "",
    "fullName": ""
  };

  SharedPreferences _prefs = App().sharedPreferences;

  @override
  AuthState get initialState => InitialAuthState();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is RegisterPasswordObscureEvent) {
      yield* _registerPasswordObscure();
    } else if (event is SaveWrittenAuthDataEvent) {
      yield* _saveWrittenAuthData(event);
    } else if (event is DoRegisterEvent) {
      yield* _doRegister(event);
    } else if (event is AutoValidateOnEvent) {
      this.isRegisterAutoValidateOn = true;
      yield InitialAuthState();
    } else if (event is ToggleEmailRegisteredEvent) {
      yield* _toggleEmailRegistered();
    }

    if (event is LoginAutoValidateOnEvent) {
      this.isLoginAutoValidateOn = true;
      yield InitialAuthState();
    } else if (event is DoLoginEvent) {
      yield* _doLogin(event);
    }

    if (event is LogoutEvent) {
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
    this.isLoginLoading = true;
    yield InitialAuthState();

    Map<String, dynamic> payload = {
      "email": event.email.trim(),
      "password": event.password.trim(),
    };
    LoginModel result = await _userService.doLogin(payload);

    this.isLoginLoading = false;
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
      App().setDioHeader();
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

  Stream<AuthState> _saveWrittenAuthData(SaveWrittenAuthDataEvent event) async* {
    yield InitialAuthState();
    this.writtenAuthData['email'] = event.email;
    this.writtenAuthData['password'] = event.password;
    this.writtenAuthData['fullName'] = event.fullName;
    yield SaveWrittenAuthDataState();
  }
}
