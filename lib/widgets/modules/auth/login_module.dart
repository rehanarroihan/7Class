import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sevenclass/bloc/auth/bloc.dart';
import 'package:sevenclass/helpers/app_color.dart';
import 'package:sevenclass/helpers/constant_helper.dart';
import 'package:sevenclass/screens/main_screen.dart';
import 'package:sevenclass/widgets/base/primary_button.dart';
import 'package:sevenclass/widgets/base/toast.dart';

class LoginModule extends StatefulWidget {
  Function onRegisterClick;

  LoginModule({this.onRegisterClick});

  @override
  _LoginModuleState createState() => _LoginModuleState();
}

class _LoginModuleState extends State<LoginModule> {
  AuthBloc _authBloc  = AuthBloc();

  GlobalKey<FormState> _loginFormState = GlobalKey();
  TextEditingController _emailTEC = new TextEditingController();
  TextEditingController _passwordTEC = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    double _screenHeight = MediaQuery.of(context).size.height;

    return BlocListener(
      bloc: _authBloc,
      listener: (context, state) {
        if (state is RegisterResultState) {
          Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => MainScreen())
          );
        } else if (state is RegisterFailedState) {
          showToast(state.message);
        }
      },
      child: BlocBuilder(
        bloc: _authBloc,
        builder: (context, state) => _loginWidget()
      ),
    );
  }

  Widget _loginWidget() {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Selamat Datang,',
            style: TextStyle(
              fontFamily: ConstantHelper.PRIMARY_FONT,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryColor,
              fontSize: 24,
            ),
          ),
          Text(
            'Masuk menggunakan emailmu',
            style: TextStyle(
              fontFamily: ConstantHelper.SECONDARY_FONT,
              fontWeight: FontWeight.w500,
              fontSize: 24,
            ),
          ),
          SizedBox(height: 24),
          Form(
            key: _loginFormState,
            child: Column(children: <Widget>[
              SizedBox(height: 18),
              TextFormField(
                controller: _emailTEC,
                autovalidate: _authBloc.isLoginAutoValidateOn,
                enabled: !_authBloc.isLoginLoading,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Email",
                  suffix: _authBloc.isEmailAlreadyRegistered ?
                  Icon(Icons.close, color: Colors.red) : null
                ),
                onChanged: (value) {
                  if (_authBloc.isEmailAlreadyRegistered) {
                    _authBloc.add(ToggleEmailRegisteredEvent());
                  }
                },
                validator: (value) {
                  if (value == "") {
                    return 'Masukkan email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 18),
              TextFormField(
                controller: _passwordTEC,
                keyboardType: TextInputType.text,
                obscureText: _authBloc.registerPasswordObscure,
                autovalidate: _authBloc.isLoginAutoValidateOn,
                enabled: !_authBloc.isLoginLoading,
                decoration: InputDecoration(
                  labelText: "Kata Sandi",
                  suffixIcon: IconButton(
                    icon: Icon(!_authBloc.registerPasswordObscure
                        ? Icons.visibility
                        : Icons.visibility_off
                    ),
                    onPressed: () {
                      _authBloc.add(RegisterPasswordObscureEvent());
                    }
                  ),
                ),
                validator: (value) {
                  if (value == "") {
                    return 'Masukkan kata sandi';
                  }
                  return null;
                },
              ),
              SizedBox(height: 32),
              Container(
                width: double.infinity,
                child: PrimaryButton(
                  text: _authBloc.isLoginLoading ? 'Please wait...' : 'Masuk',
                  onTap: () {
                    !_authBloc.isRegisterLoading ? _doLogin() : null;
                  },
                )
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Email belum terdaftar ?',
                      style: TextStyle(
                        fontFamily: ConstantHelper.SECONDARY_FONT,
                        fontSize: 15
                      ),
                    ),
                    InkWell(
                      onTap: widget.onRegisterClick,
                      child: Text(
                        ' Daftar disini',
                        style: TextStyle(
                          fontFamily: ConstantHelper.SECONDARY_FONT,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 15
                        ),
                      ),
                    )
                  ],
                )
              )
            ]),
          ),
        ],
      ),
    );
  }

  _doLogin() {
    _loginFormState.currentState.save();
    _authBloc.add(LoginAutoValidateOnEvent());
    bool valid = _loginFormState.currentState.validate();

    if (!valid) {
      return false;
    }

    String email = _emailTEC.text;
    String password = _passwordTEC.text;

    _authBloc.add(DoLoginEvent(
        email: email,
        password: password
    ));
  }
}
