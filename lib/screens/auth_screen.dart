import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sevenclass/bloc/auth/auth_bloc.dart';
import 'package:sevenclass/bloc/auth/auth_event.dart';
import 'package:sevenclass/bloc/auth/auth_state.dart';
import 'package:sevenclass/helpers/app_color.dart';
import 'package:sevenclass/helpers/constant_helper.dart';
import 'package:sevenclass/widgets/base/toast.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class AuthScreen extends StatelessWidget {
  AuthBloc _authBloc  = AuthBloc();

  TextEditingController _nameTEC = new TextEditingController();
  TextEditingController _emailTEC = new TextEditingController();
  TextEditingController _passwordTEC = new TextEditingController();

  GlobalKey<FormState> _registerFormState = GlobalKey();

  @override
  Widget build(BuildContext context) {
    double _screenHeight = MediaQuery.of(context).size.height;

    return BlocListener(
      bloc: _authBloc,
      listener: (context, state) {
        if (state is RegisterResultState) {
          _neverSatisfied(context);
        } else if (state is RegisterFailedState) {
          showToast(state.message);
        }
      },
      child: BlocBuilder(
        bloc: _authBloc,
        builder: (context, state){
         return Scaffold(
          appBar: AppBar(
            title: Text('Register'),
          ),
          body: SlidingUpPanel(
            minHeight: _screenHeight * 0.5,
            panel: _registerWidget(),
            body: Container(
              height: MediaQuery.of(context).size.height,
              color: Colors.transparent,
            ),
          ),
        );
      }
      ),
    );
  }

  Widget _registerWidget() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Selamat Datang,',
            style: TextStyle(
              fontFamily: ConstantHelper.PRIMARY_FONT,
              fontWeight: FontWeight.w500,
              color: AppColors.bluePrimary,
              fontSize: 24,
            ),
          ),
          Text(
            'Buat akunmu sekarang!',
            style: TextStyle(
              fontFamily: ConstantHelper.SECONDARY_FONT,
              fontWeight: FontWeight.w500,
              fontSize: 24,
            ),
          ),
          SizedBox(height: 32),
          Form(
            key: _registerFormState,
            child: Column(children: <Widget>[
              TextFormField(
                controller: _nameTEC,
                decoration: InputDecoration(
                    labelText: "Nama Lengkap"
                ),
                validator: (value) {
                  if (value == "") {
                    return 'Masukkan nama lengkap';
                  }

                  return null;
                },
                autovalidate: true,
              ),
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
                validator: validateEmail,
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
                  } else if (value.length < 8) {
                    return "Kata sandi kurang dari 8 karakter";
                  }

                  return null;
                },
                autovalidate: true,
              ),
              SizedBox(height: 32),
              Container(
                width: double.infinity,
                child: RaisedButton(
                  onPressed: () => !_authBloc.isRegisterLoading ? _doRegister() : null,
                  color: AppColors.bluePrimary,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Text(
                    _authBloc.isRegisterLoading ? 'Please wait...' : 'Register',
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: ConstantHelper.PRIMARY_FONT,
                        fontWeight: FontWeight.w600,
                        color: Colors.white
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (value.isEmpty)
      return 'Email Tidak Boleh Kosong';
    else if (!regex.hasMatch(value))
      return 'Masukkan Email yang valid';
    else if (_authBloc.isEmailAlreadyRegistered)
      return "Email already registered";
    else if (value == _authBloc.previousRegisteredEmail)
      return "Email already registered";
    else
      return null;
  }

  Future<void> _neverSatisfied(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Rewind and remember'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('You will never be satisfied.'),
                Text('You\’re like me. I’m never satisfied.'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Regret'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  _doRegister() {
    _registerFormState.currentState.save();
    bool valid = _registerFormState.currentState.validate();

    if (!valid) {
      return false;
    }

    String email = _emailTEC.text;
    String password = _passwordTEC.text;
    String fullName = _nameTEC.text;

    _authBloc.add(DoRegisterEvent(
      email: email,
      password: password,
      fullName: fullName
    ));
  }
}