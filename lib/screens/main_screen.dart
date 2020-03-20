import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sevenclass/bloc/auth/bloc.dart';
import 'package:sevenclass/bloc/home/bloc.dart';
import 'package:sevenclass/screens/main_sections/class_list_screen.dart';
import 'package:sevenclass/screens/main_sections/overview_screen.dart';
import 'package:sevenclass/screens/main_sections/profile_screen.dart';
import 'package:sevenclass/screens/welcome_screen.dart';

class MainScreen extends StatelessWidget {
  AuthBloc _authBloc;
  HomeBloc _homeBloc;

  @override
  Widget build(BuildContext context) {
    _authBloc = BlocProvider.of<AuthBloc>(context);
    _homeBloc = BlocProvider.of<HomeBloc>(context);

    return BlocListener(
      bloc: _authBloc,
      listener: (BuildContext context, AuthState state) {
        if (state is LogoutState) {
          Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => WelcomeScreen())
          );
        }
      },
      child: BlocBuilder(
        bloc: _homeBloc,
        builder: (context, state) {
          return Scaffold(
            body: _body(),
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color(0XFFD3D6DA).withAlpha(50),
                    offset: Offset(0, -2),
                    blurRadius: 1,
                    spreadRadius: 1
                  )
                ]
              ),
              child: Row(
                children: <Widget>[
                  _bottomMenuItem(
                    icon: Icons.dashboard,
                    iconColor: Colors.grey[500],
                    onPressed: () {
                      _homeBloc.add(ChangeSectionEvent(
                        sectionActive: SectionActive.OVERVIEW
                      ));
                    }
                  ),
                  _bottomMenuItem(
                    icon: Icons.folder,
                    iconColor: Colors.grey[500],
                    onPressed: () {
                      _homeBloc.add(ChangeSectionEvent(
                        sectionActive: SectionActive.CLASSES
                      ));
                    }
                  ),
                  _bottomMenuItem(
                    icon: Icons.playlist_add_check,
                    iconColor: Colors.grey[500],
                    onPressed: () {}
                  ),
                  _bottomMenuItem(
                    icon: Icons.person,
                    iconColor: Colors.grey[500],
                    onPressed: () {
                      _homeBloc.add(ChangeSectionEvent(
                          sectionActive: SectionActive.PROFILE
                      ));
                    }
                  )
                ]
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _body() {
    if (_homeBloc.sectionActive == SectionActive.OVERVIEW) {
      return OverviewScreen();
    } else if (_homeBloc.sectionActive == SectionActive.CLASSES) {
      return ClassListScreen();
    } else if (_homeBloc.sectionActive == SectionActive.PROFILE) {
      return ProfileScreen();
    } else {
      return null;
    }
  }

  Widget _bottomMenuItem({IconData icon, Color iconColor, Function onPressed}) {
    return Expanded(
      child: FlatButton(
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0)
        ),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 15),
          child: Icon(
            icon,
            color: iconColor,
          ),
        ),
      ),
    );
  }
}
