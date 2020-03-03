import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sevenclass/bloc/auth/bloc.dart';
import 'package:sevenclass/helpers/app_color.dart';
import 'package:sevenclass/helpers/constant_helper.dart';

class LoginModule extends StatelessWidget {
  Function onRegisterClick;
  LoginModule({this.onRegisterClick});

  AuthBloc _authBloc  = AuthBloc();

  TextEditingController _emailTEC = new TextEditingController();
  TextEditingController _passwordTEC = new TextEditingController();

  GlobalKey<FormState> _registerFormState = GlobalKey();

  _doLogin() {
    _registerFormState.currentState.save();
    bool valid = _registerFormState.currentState.validate();

    if (!valid) {
      return false;
    }

    String email = _emailTEC.text;
    String password = _passwordTEC.text;

    _authBloc.add(DoRegisterEvent(
        email: email,
        password: password
    ));
  }

  @override
  Widget build(BuildContext context) {
    double _screenHeight = MediaQuery.of(context).size.height;

    return BlocListener(
      bloc: _authBloc,
      listener: (context, state) {
        if (state is RegisterResultState) {

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
            key: _registerFormState,
            child: Column(children: <Widget>[
              SizedBox(height: 18),
              TextFormField(
                controller: _emailTEC,
                autovalidate: true,
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
                autovalidate: true,
              ),
              SizedBox(height: 32),
              Container(
                width: double.infinity,
                child: RaisedButton(
                  onPressed: () => !_authBloc.isRegisterLoading ? _doLogin() : null,
                  color: AppColors.primaryColor,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Text(
                    _authBloc.isRegisterLoading ? 'Please wait...' : 'Masuk',
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: ConstantHelper.PRIMARY_FONT,
                        fontWeight: FontWeight.w600,
                        color: Colors.white
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(18),
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
                      onTap: onRegisterClick,
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
                ))
            ]),
          ),
        ],
      ),
    );
  }
}
