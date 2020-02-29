import 'package:flutter/material.dart';
import 'package:sevenclass/helpers/constant_helper.dart';

class Descriptive extends StatelessWidget {
  final String title;
  final String description;

  Descriptive({this.title, this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            fontFamily: ConstantHelper.PRIMARY_FONT,
            fontWeight: FontWeight.w700,
            fontSize: 24,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 15.0,
        ),
        Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.0),
            child: Text(
              description,
              style: TextStyle(
                fontFamily: ConstantHelper.SECONDARY_FONT,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        )
      ],
    );
  }
}
