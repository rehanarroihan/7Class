import 'package:flutter/material.dart';

class AppAlertDialog {
  final String title;
  final String message;
  final String leftButtonText;
  final String rightButtonText;
  final Color rightButtonColor;
  final Function onLeftButtonClick;
  final Function onRightButtonClick;

  AppAlertDialog({
    @required this.title,
    @required this.message,
    this.leftButtonText,
    this.rightButtonColor,
    this.onLeftButtonClick,
    @required this.rightButtonText,
    @required this.onRightButtonClick
  });

  Widget _alertWidget(context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8)
      ),
      actions: <Widget>[
        leftButtonText != null ? FlatButton(
          child: Text(leftButtonText),
          onPressed: onLeftButtonClick
        ) : null,
        FlatButton(
          child: Text(
            rightButtonText,
            style: TextStyle(
              color: rightButtonColor ?? Colors.blue
            )
          ),
          onPressed: onRightButtonClick,
        ),
      ],
    );
  }

  void show(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => _alertWidget(context)
    );
  }
}
