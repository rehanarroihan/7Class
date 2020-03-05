import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sevenclass/bloc/auth/bloc.dart';

class ProfileScreen extends StatelessWidget {
  AuthBloc _authBloc;

  @override
  Widget build(BuildContext context) {
    _authBloc = BlocProvider.of<AuthBloc>(context);

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool isScrolling) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(
                  "Collapsing Toolbar",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  )
                ),
                background: Image.network(
                  "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
                  fit: BoxFit.cover,
                )
              ),
            ),
          ];
        },
        body: Container(
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                child: FlatButton(
                  onPressed: () {},
                  child: Text('Bajingan'),
                ),
              ),
              SizedBox(height: 100),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                child: FlatButton(
                  onPressed: () {},
                  child: Text('Bajingan'),
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                child: FlatButton(
                  onPressed: () {},
                  child: Text('Bajingan'),
                ),
              ),
              SizedBox(height: 50),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                child: FlatButton(
                  onPressed: () {},
                  child: Text('Bajingan'),
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                child: FlatButton(
                  onPressed: () {},
                  child: Text('Bajingan'),
                ),
              ),
              SizedBox(height: 100),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                child: FlatButton(
                  onPressed: () {
                    _authBloc.add(LogoutEvent());
                  },
                  child: Text('Logout'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
