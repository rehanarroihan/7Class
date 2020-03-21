import 'package:flutter/material.dart';
import 'package:sevenclass/helpers/app_color.dart';
import 'package:sevenclass/helpers/constant_helper.dart';

enum ButtonStyle {
  PRIMARY,
  OUTLINE,
  DANGER,
  FLAT
}

class Button extends StatelessWidget {
  final String text;
  final Function onTap;
  final ButtonStyle style;
  final bool isRounded;

  Button({
    @required this.text,
    @required this.onTap,
    @required this.style,
    this.isRounded = false
  });

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onTap,
      color: style == ButtonStyle.PRIMARY
          ? AppColors.primaryColor
        : style == ButtonStyle.PRIMARY
          ? Colors.red[500]
        : AppColors.primaryColor,
      padding: EdgeInsets.symmetric(vertical: 14),
      highlightElevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(isRounded ? 18 : 14)
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 18,
          fontFamily: ConstantHelper.PRIMARY_FONT,
          fontWeight: FontWeight.w600,
          color: AppColors.white
        ),
      ),
    );
  }
}
