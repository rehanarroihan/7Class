import 'dart:async';

import 'package:dio/dio.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sevenclass/widgets/base/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bloc/bloc_delegate.dart';
import 'helpers/constant_helper.dart';

enum Flavor { DEVELOPMENT, PRODUCTION }

class App {
  final Flavor flavor;
  final String apiBaseURL;
  final String appTitle;
  static App _instance;

  SharedPreferences sharedPreferences;
  Dio dio;

  App.configure({
    this.flavor,
    this.apiBaseURL,
    this.appTitle
  }) {
    _instance = this;
  }

  factory App() {
    if (_instance == null) {
      throw UnimplementedError("App must be configured first.");
    }

    return _instance;
  }

  Future<Null> init() async {
    sharedPreferences = await SharedPreferences.getInstance();

    // configure blog delegate
    BlocSupervisor.delegate = SimpleBlocDelegate();

    Crashlytics.instance.enableInDevMode = true;
    Crashlytics.instance.setUserEmail('Unauthorized');
    Crashlytics.instance.setUserName('Unauthorized');
    Crashlytics.instance.setUserIdentifier('Unauthorized');

    FlutterError.onError = (FlutterErrorDetails details) {
      Crashlytics.instance.recordFlutterError(details);
    };

    dio = Dio(
      BaseOptions(
        baseUrl: apiBaseURL,
        connectTimeout: 10000,
        receiveTimeout: 30000,
        responseType: ResponseType.json
      )
    );
    dio.options.headers = {
      'Authorization': sharedPreferences.get(ConstantHelper.AUTH_TOKEN_PREF)
    };
    setDioInterceptor();
  }

  void setDioInterceptor() {
    dio.interceptors.add(InterceptorsWrapper(onError: (DioError e) async {
      Map<String, dynamic> data = e.response.data;
      if (e.response.statusCode != null) {
        if (e.response.statusCode == 400) {
          showToast(data['message']);
        }
      }
      return e;
    }));
  }
}