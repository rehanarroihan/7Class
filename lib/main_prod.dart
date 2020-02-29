import 'package:flutter/material.dart';
import 'package:flutter_stetho/flutter_stetho.dart';
import 'package:sevenclass/main_layout.dart';

import 'app.dart';

Future<Null> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  App.configure(
      flavor: Flavor.DEVELOPMENT,
      apiBaseURL: 'https://multazamgsd.com/7class/v1/',
      appTitle: '7Class Development'
  );

  await App().init();
  Stetho.initialize();

  runApp(MainLayout());
}
