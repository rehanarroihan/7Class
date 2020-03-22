import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sevenclass/helpers/app_color.dart';
import 'package:sevenclass/helpers/constant_helper.dart';

class CameraPermission extends StatelessWidget {
  final Function onGo;

  CameraPermission({this.onGo});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.camera, size: 125, color: Colors.grey[300]),
          SizedBox(height: 12),
          Text(
            'Bolehkah kami mengakses kamera mu ?',
            style: TextStyle(
              fontFamily: ConstantHelper.PRIMARY_FONT,
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: AppColors.white
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4),
          Text(
            'Mohon berikan kami akses kamera agar anda dapat\nbergabung ke kelas melalui QR Code.',
            style: TextStyle(
              fontFamily: ConstantHelper.SECONDARY_FONT,
              fontSize: 13,
              color: Colors.grey[300]
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
          RaisedButton(
            onPressed: onGo,
            color: AppColors.primaryColor,
            padding: EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8)
            ),
            child: Text(
              'HAYUK',
              style: TextStyle(
                fontSize: 16,
                fontFamily: ConstantHelper.PRIMARY_FONT,
                fontWeight: FontWeight.w600,
                color: AppColors.white
              ),
            ),
          ),
        ]
      ),
    );
  }
}
