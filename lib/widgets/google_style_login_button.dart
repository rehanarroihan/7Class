import 'package:flutter/material.dart';
import 'package:sevenclass/helpers/constant_helper.dart';

class GoogleStyleLoginButton extends StatelessWidget {
  final Function onPressed;

  GoogleStyleLoginButton({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/images/icons/google.png'),
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
