import 'package:flutter/material.dart';
import 'package:sevenclass/helpers/app_color.dart';
import 'package:sevenclass/helpers/constant_helper.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final Function onTap;
  final bool isRounded;

  PrimaryButton({
    @required this.text,
    @required this.onTap,
    this.isRounded = false
  });

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onTap,
      color: AppColors.primaryColor,
      padding: EdgeInsets.symmetric(vertical: 14),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(isRounded ? 18 : 14)
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 18,
          fontFamily: ConstantHelper.PRIMARY_FONT,
          fontWeight: FontWeight.w600,
          color: Colors.white
        ),
      ),
    );
  }
}
