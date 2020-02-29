import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;

  AppText(this.text, {this.fontSize, this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'Gilroy',
        fontSize: fontSize,
        fontWeight: fontWeight
      ),
    );
  }
}
