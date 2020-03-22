import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sevenclass/app.dart';
import 'package:sevenclass/bloc/auth/bloc.dart';
import 'package:sevenclass/helpers/app_color.dart';
import 'package:sevenclass/helpers/constant_helper.dart';

class OverviewScreen extends StatelessWidget {
  AuthBloc _authBloc;

  @override
  Widget build(BuildContext context) {
    _authBloc = BlocProvider.of<AuthBloc>(context);

    return Scaffold(
      backgroundColor: Color(0xFFf2f6ff),
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        actions: <Widget>[

        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              // Greetings
              Container(
                padding: EdgeInsets.symmetric(horizontal: 22, vertical: 24),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40.0),
                    bottomRight: Radius.circular(40.0)
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Hi, ${App().sharedPreferences.getString(ConstantHelper.USER_FIRST_NAME_PREF)}!",
                      style: TextStyle(
                        fontFamily: ConstantHelper.PRIMARY_FONT,
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: AppColors.greyTertiary
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      "Selamat Pagi",
                      style: TextStyle(
                        fontFamily: ConstantHelper.PRIMARY_FONT,
                        fontWeight: FontWeight.w600,
                        fontSize: 32,
                        color: AppColors.black
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      "30 April 2019",
                      style: TextStyle(
                        fontFamily: ConstantHelper.PRIMARY_FONT,
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: AppColors.greyTertiary
                      ),
                    ),
                    SizedBox(height: 12)
                  ],
                ),
              ),

              // Content
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(
                              right: 16
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xFFf2f6ff),
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                            ),
                            height: 80,
                            width: 80,
                            child: Icon(
                              Icons.remove_from_queue,
                              size: 32,
                              color: AppColors.primaryColor
                            ),
                          ),

                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Total Task Progress",
                                style: TextStyle(
                                  fontFamily: ConstantHelper.PRIMARY_FONT,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  color: AppColors.black
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),

                    SizedBox(height: 16),
                    Text(
                      "Nearest Deadline",
                      style: TextStyle(
                          fontFamily: ConstantHelper.PRIMARY_FONT,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: AppColors.black
                      ),
                    ),

                    SizedBox(height: 16),
                    Text(
                      "Class Shortcut",
                      style: TextStyle(
                          fontFamily: ConstantHelper.PRIMARY_FONT,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: AppColors.black
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _completionPercent(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double  maxBarWidth = constraints.maxWidth;
        final double percent = (8 - 3) / 8;
        double barWidth = percent * maxBarWidth;

        if (barWidth < 0) {
          barWidth = 0;
        }

        return Stack(
          children: <Widget>[
            Container(
              height: 20,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: AppColors.greyBackground,
                  borderRadius: BorderRadius.circular(15)
              ),
            ),
            Container(
              height: 20,
              width: barWidth,
              decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(15)
              ),
            )
          ],
        );
      },
    );
  }
}
