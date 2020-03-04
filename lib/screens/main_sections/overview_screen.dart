import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sevenclass/app.dart';
import 'package:sevenclass/bloc/auth/bloc.dart';
import 'package:sevenclass/helpers/constant_helper.dart';

class OverviewScreen extends StatelessWidget {
  AuthBloc _authBloc;

  @override
  Widget build(BuildContext context) {
    _authBloc = BlocProvider.of<AuthBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('7Class'),
        elevation: 0,
        actions: <Widget>[
          IconButton(
            onPressed: () => _authBloc.add(LogoutEvent()),
            icon: Icon(Icons.exit_to_app),
          )
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0)
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Selamat Pagi,",
                    style: TextStyle(
                        fontFamily: ConstantHelper.PRIMARY_FONT,
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Colors.grey[200]
                    ),
                  ),
                  Text(
                    "${App().sharedPreferences.getString(ConstantHelper.USER_FIRST_NAME_PREF)} "
                        "${App().sharedPreferences.getString(ConstantHelper.USER_LAST_NAME_PREF)}",
                    style: TextStyle(
                        fontFamily: ConstantHelper.PRIMARY_FONT,
                        fontWeight: FontWeight.w600,
                        fontSize: 32,
                        color: Colors.grey[200]
                    ),
                  ),
                  Text(
                    App().sharedPreferences.getString(ConstantHelper.USER_EMAIL_PREF),
                    style: TextStyle(
                        fontFamily: ConstantHelper.PRIMARY_FONT,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Colors.grey[200]
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
