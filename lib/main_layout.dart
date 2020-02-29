import 'package:flutter/material.dart';
import 'package:sevenclass/screens/intro_screen.dart';

import 'app.dart';

class MainLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: App().appTitle,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: IntroScreen(),
    );
  }
}
