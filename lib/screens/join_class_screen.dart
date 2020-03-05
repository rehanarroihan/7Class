import 'package:flutter/material.dart';
import 'package:sevenclass/helpers/app_color.dart';
import 'package:sevenclass/helpers/constant_helper.dart';
import 'package:sevenclass/widgets/base/finger_tip.dart';
import 'package:sevenclass/widgets/base/sliding_panel.dart';
import 'package:sevenclass/widgets/modules/classes/camera_permission.dart';

class JoinClassScreen extends StatelessWidget {
  PanelController _pc = PanelController();
  double _screenHeight = 0;

  @override
  Widget build(BuildContext context) {
    _screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SlidingPanel(
        controller: _pc,
        isDraggable: false,
        minHeight: _screenHeight * 0.32,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0)
        ),
        body: Container(
          color: Colors.black87,
          child: Container(
            width: 100,
            child: Column(
              children: <Widget>[
                SizedBox(height: 38),
                Row(
                  children: <Widget>[
                    SizedBox(width: 14),
                    SizedBox(
                      height: 40,
                      width: 40,
                      child: FloatingActionButton(
                        elevation: 0,
                        highlightElevation: 0,
                        backgroundColor: Colors.white,
                        onPressed: () => Navigator.pop(context),
                        child: Icon(Icons.arrow_back, color: Colors.black87),
                      ),
                    )
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                CameraPermission(),
              ],
            ),
          ),
        ),
        panel: Container(
          padding: EdgeInsets.only(
            top: 16,
            right: 32,
            bottom: 32,
            left: 32
          ),
          child: Column(
            children: <Widget>[
              FingerTip(),
              SizedBox(height: 23),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Atau masukkan kode kelas secara manual',
                    style: TextStyle(
                      fontFamily: ConstantHelper.PRIMARY_FONT,
                      fontSize: 16,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                  SizedBox(height: 12),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Kode kelas",
                      fillColor: Colors.grey[100],
                      filled: true,
                      prefixIcon: Icon(Icons.short_text, color: Colors.black54),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        borderSide: BorderSide(width: 0.8),
                      ),
                    ),
                    validator: (value) {
                      if (value == "") {
                        return 'Masukkan nama lengkap';
                      }

                      return null;
                    },
                    autovalidate: false,
                  ),
                  SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    child: RaisedButton(
                      onPressed: () {},
                      color: AppColors.primaryColor,
                      padding: EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Text(
                        'Gabung',
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: ConstantHelper.PRIMARY_FONT,
                            fontWeight: FontWeight.w600,
                            color: Colors.white
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
