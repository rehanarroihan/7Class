import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sevenclass/helpers/app_color.dart';
import 'package:sevenclass/helpers/constant_helper.dart';
import 'package:sevenclass/widgets/google_style_login_button.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  double _isMainTextShow = 0;
  double _isSecondaryTextShow = 0;

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/intro/illustration2.png')
                  )
                ),
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  color: Colors.white,
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
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                      right: 32,
                      top: 32,
                      bottom: 32,
                      left: 32
                  ),
                  child: Column(
                    children: <Widget>[
                      AnimatedOpacity(
                        duration: Duration(milliseconds: 400),
                        opacity: _isMainTextShow,
                        child: Text(
                          'Mulai Pengalaman Belajar baru mu Bersama Teman Kelas!',
                          style: TextStyle(
                            fontFamily: ConstantHelper.PRIMARY_FONT,
                            fontWeight: FontWeight.w700,
                            fontSize: 24,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      AnimatedOpacity(
                        duration: Duration(milliseconds: 400),
                        opacity: _isSecondaryTextShow,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2.0),
                          child: Text(
                            'daftarkan dirimu menggunakan akun google ataupun mendaftar dengan email baru',
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
                      SizedBox(height: 48),
                      Container(
                        width: double.infinity,
                        child: GoogleStyleLoginButton(
                          onPressed: () {
                            _doGoogleSignIn();
                          },
                        ),
                      ),
                      SizedBox(height: 12),
                      GestureDetector(
                        onTap: () {
                          /*Navigator.push(context,
                            MaterialPageRoute(builder: (context) => AuthScreen())
                          );*/
                        },
                        child: Text(
                          'Create email account >>',
                          style: TextStyle(
                              fontFamily: ConstantHelper.SECONDARY_FONT,
                              fontWeight: FontWeight.bold,
                              color: AppColors.bluePrimary
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
