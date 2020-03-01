import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sevenclass/bloc/splash/bloc.dart';
import 'package:sevenclass/screens/welcome_screen.dart';
import 'package:sevenclass/widgets/base/app_text.dart';

import 'intro_screen.dart';

class SplashScreen extends StatelessWidget {
  SplashBloc _splashBloc = SplashBloc();

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    _splashBloc.add(CheckUserConditionEvent());

    return BlocListener<SplashBloc, SplashState>(
      bloc: _splashBloc,
      listener: (BuildContext context, SplashState state) {
        if (state is LaunchedFirstTime) {
          print('im call out the intro screen');
          Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => IntroScreen()
          ));
        } else if (state is Authenticated) {
          /*Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
              return MainScreen();
            }
          ));*/
        } else if (state is NotAuthenticated) {
          Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => WelcomeScreen()
          ));
        }
      },
      child: Scaffold(
        body: Container(
          height: _height,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AppText(
                '7Class.co',
                fontSize: 32,
                fontWeight: FontWeight.w500,
              )
            ]
          ),
        ),
      ),
    );
  }
}
