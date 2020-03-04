import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sevenclass/helpers/app_color.dart';
import 'package:sevenclass/helpers/constant_helper.dart';
import 'package:sevenclass/widgets/base/finger_tip.dart';
import 'package:sevenclass/widgets/base/sliding_panel.dart';
import 'package:sevenclass/widgets/google_style_login_button.dart';
import 'package:sevenclass/widgets/modules/login_module.dart';
import 'package:sevenclass/widgets/modules/register_module.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  double _isMainTextShow = 0;
  double _isSecondaryTextShow = 0;
  PanelController _pc = PanelController();
  double _screenHeight = 0;
  bool _isRegisterModule = false;

  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  @override
  void initState() {
    _onAir();
    super.initState();
  }

  _doGoogleSignIn() async {
    try{
      await _googleSignIn.signIn().then((result) {
        print(result);
      });
    } catch (err){
      print(err);
    }
  }

  _onAir() {
    Future.delayed(const Duration(milliseconds: 200),(){
      setState(() {
        _isMainTextShow = 1;
      });
    });

    Future.delayed(const Duration(milliseconds: 600),(){
      setState(() {
        _isSecondaryTextShow = 1;
      });
    });

    Future.delayed(const Duration(milliseconds: 800),(){
      _pc.setPanelPosition(0.5);
    });
  }

  _onBackPressed() {
    print('dancok');
    Navigator.of(context).pop(false);
    /*if (_pc.isPanelOpen()) {
      _pc.close();
    }*/
  }

  @override
  Widget build(BuildContext context) {
    _screenHeight =  MediaQuery.of(context).size.height;

    return Scaffold(
      body: SlidingPanel(
        controller: _pc,
        maxHeight: _screenHeight - (_screenHeight * 0.115),
        minHeight: _screenHeight * 0.1,
        panel: Container(),
        body: _illustration(),
        border: Border.all(color: Colors.white),
        boxShadow: [
          BoxShadow(
            color: AppColors.grey,
            offset: Offset(0, -1),
            spreadRadius: 1,
            blurRadius: 20
          )
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0)
        ),
        snappingWidgets: {
          0.99999999: Container(
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
                _isRegisterModule ?
                RegisterModule(
                  onLoginClick: () {
                    setState(() {
                      _isRegisterModule = false;
                    });
                  },
                ) :
                LoginModule(
                  onRegisterClick: () {
                    setState(() {
                      _isRegisterModule = true;
                    });
                  },
                ),
              ]
            ),
          ),
          0.195: _nineTeenPoint(),
        },
      ),
    );
  }

  Widget _nineTeenPoint() {
    return Padding(
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
          Container(
            width: double.infinity,
            child: GoogleStyleLoginButton(
              onPressed: () {
                //_doGoogleSignIn();
              },
            ),
          ),
          SizedBox(height: 4),
          RaisedButton(
            onPressed: () {
              _pc.open();
            },
            color: Colors.transparent,
            elevation: 0,
            highlightElevation: 0,
            highlightColor: Color(0xFFECEFF1),
            splashColor: Colors.grey[200],
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0)
            ),
            child: Text(
              'Atau masuk dengan email',
              style: TextStyle(
                fontFamily: ConstantHelper.SECONDARY_FONT,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _illustration() {
    return Column(
      children: <Widget>[
        SizedBox(height: _screenHeight * 0.12),
        Container(
          height: _screenHeight * 0.4,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/intro/illustration2.png')
              )
          ),
        ),
        SizedBox(height: 12.0),
        AnimatedOpacity(
          duration: Duration(milliseconds: 400),
          opacity: _isMainTextShow,
          child: Text(
            'Gaya belajar baru bersama \nteman kelas',
            style: TextStyle(
              fontFamily: ConstantHelper.PRIMARY_FONT,
              fontWeight: FontWeight.w700,
              fontSize: 24,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 15.0),
        AnimatedOpacity(
          duration: Duration(milliseconds: 400),
          opacity: _isSecondaryTextShow,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.0),
            child: Text(
              'Daftar sekarang untuk menikmati pengalaman baru belajar bersama teman kelasmu!',
              style: TextStyle(
                fontFamily: ConstantHelper.SECONDARY_FONT,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
