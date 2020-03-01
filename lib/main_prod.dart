import 'package:flutter/material.dart';
import 'package:flutter_stetho/flutter_stetho.dart';

import 'app.dart';
import 'main_layout.dart';

Future<Null> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  App.configure(
    flavor: Flavor.DEVELOPMENT,
    apiBaseURL: 'https://multazamgsd.com/7class/v1/',
    appTitle: '7Class'
  );

  await App().init();
  Stetho.initialize();

  runApp(MainLayout());
}
