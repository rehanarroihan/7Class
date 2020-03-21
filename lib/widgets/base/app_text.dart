import 'package:flutter/material.dart';
import 'package:sevenclass/helpers/constant_helper.dart';

enum AppTextStyle {
  PRIMARY,
  SECONDARY,

}

class AppText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;

  AppText({
    @required this.text,
    this.fontSize,
    this.fontWeight
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: ConstantHelper.PRIMARY_FONT,
        fontSize: fontSize,
        fontWeight: fontWeight
      ),
    );
  }
}
