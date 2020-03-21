import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sevenclass/helpers/app_color.dart';
import 'package:sevenclass/helpers/constant_helper.dart';

class GoogleStyleLoginButton extends StatelessWidget {
  final Function onPressed;

  GoogleStyleLoginButton({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[400].withOpacity(0.3),
            offset: Offset(0, -1),
            spreadRadius: 1,
            blurRadius: 20
          )
        ],
      ),
      child: FlatButton(
        onPressed: onPressed,
        color: AppColors.white,
        padding: EdgeInsets.symmetric(vertical: 14),
        highlightColor: Colors.grey[300],
        splashColor: Colors.lightBlueAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
              "assets/images/icons/google.svg",
              width: 20.0,
              height: 20.0,
            ),
            SizedBox(width: 8),
            Text(
              'Continue with Google',
              style: TextStyle(
                fontFamily: ConstantHelper.SECONDARY_FONT,
                fontSize: 16
              ),
            )
          ]
        ),
      ),
    );
  }
}
