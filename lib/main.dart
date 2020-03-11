import 'package:flutter/material.dart';
import 'package:flutter_stetho/flutter_stetho.dart';
import 'package:sevenclass/main_layout.dart';

import 'app.dart';

Future<Null> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  App.configure(
    flavor: Flavor.DEVELOPMENT,
    apiBaseURL: 'http://192.168.137.1:8087/v1/',
    appTitle: '7Class Development'
  );

  await App().init();
  Stetho.initialize();

  runApp(MainLayout());
}
