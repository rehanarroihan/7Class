import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sevenclass/bloc/auth/bloc.dart';
import 'package:sevenclass/helpers/app_color.dart';
import 'package:sevenclass/helpers/constant_helper.dart';
import 'package:sevenclass/widgets/base/button.dart';

import '../../app.dart';

class ProfileScreen extends StatelessWidget {
  AuthBloc _authBloc;

  @override
  Widget build(BuildContext context) {
    _authBloc = BlocProvider.of<AuthBloc>(context);

    return Scaffold(
      backgroundColor: AppColors.greyBackground,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Profile',
                      style: TextStyle(
                        fontFamily: ConstantHelper.PRIMARY_FONT,
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                      ),
                    ),
                    SizedBox(height: 18),
                    Row(
                      children: <Widget>[
                        Icon(Icons.person_pin, size: 48, color: AppColors.primaryColor),
                        SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              App().sharedPreferences.getString(ConstantHelper.USER_FIRST_NAME_PREF).toUpperCase(),
                              style: TextStyle(
                                fontFamily: ConstantHelper.PRIMARY_FONT,
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              App().sharedPreferences.getString(ConstantHelper.USER_EMAIL_PREF),
                              style: TextStyle(
                                fontFamily: ConstantHelper.PRIMARY_FONT,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 16),
              Container(
                width: double.infinity,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                        top: 16,
                        left: 16,
                        right: 16
                      ),
                      child: Text(
                        'Account',
                        style: TextStyle(
                          fontFamily: ConstantHelper.PRIMARY_FONT,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    SizedBox(height: 6),
                    _menuItem(
                      onTap: () {},
                      icon: Icons.edit,
                      text: 'Update Profile'
                    ),
                    _menuItem(
                      onTap: () {},
                      icon: Icons.directions,
                      text: 'Change Password',
                    ),
                    _menuItem(
                      onTap: () {},
                      icon: Icons.language,
                      text: 'Change Language',
                      isBorder: false
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Container(
                width: double.infinity,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                        top: 16,
                        left: 16,
                        right: 16
                      ),
                      child: Text(
                        'Other',
                        style: TextStyle(
                          fontFamily: ConstantHelper.PRIMARY_FONT,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    SizedBox(height: 6),
                    _menuItem(
                      onTap: () {},
                      icon: Icons.help,
                      text: 'Privacy Policy'
                    ),
                    _menuItem(
                      onTap: () {

                      },
                      icon: Icons.people,
                      text: 'Invite Friend',
                      isBorder: false
                    )
                  ],
                ),
              ),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Version',
                      style: TextStyle(
                        fontFamily: ConstantHelper.PRIMARY_FONT,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      '#BelajarDariManaSaja',
                      style: TextStyle(
                        fontFamily: ConstantHelper.PRIMARY_FONT,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 18),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Button(
                  style: ButtonStyle.PRIMARY,
                  text: 'Logout',
                  isRounded: true,
                  onTap: () => _authBloc.add(LogoutEvent()),
                ),
              ),
              SizedBox(height: 18),
            ],
          ),
        ),
      ),
    );
  }

  Widget _menuItem({Function onTap, IconData icon, String text, bool isBorder = true}) {
    return Container(
      decoration: BoxDecoration(
        border: isBorder ? Border(
          bottom: BorderSide(
            color: Color(0xFFF5F5F5),
            width: 0.8
          ),
        ) : null,
      ),
      child: FlatButton(
        onPressed: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0)
        ),
        child: ListTile(
          leading: Icon(icon, color: Colors.black),
          contentPadding: EdgeInsets.all(0),
          title: Align(
            alignment: Alignment(-1.2, 0),
            child: Text(
              text,
              style: TextStyle(
                fontFamily: ConstantHelper.PRIMARY_FONT,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
          trailing: Icon(Icons.chevron_right, color: Color(0xFF706f74)),
        )
      ),
    );
  }
}
