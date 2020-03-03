import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sevenclass/bloc/auth/bloc.dart';
import 'package:sevenclass/screens/welcome_screen.dart';

class AuditoriumPage extends StatelessWidget {
  AuthBloc _authBloc;

  @override
  Widget build(BuildContext context) {
    _authBloc = BlocProvider.of<AuthBloc>(context);

    return BlocListener(
      bloc: _authBloc,
      listener: (BuildContext context, AuthState state) {
        if (state is LogoutState) {
          Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => WelcomeScreen())
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('7Class'),
          actions: <Widget>[
            IconButton(
              onPressed: () => _authBloc.add(LogoutEvent()),
              icon: Icon(Icons.exit_to_app),
            )
          ],
        ),
      ),
    );
  }
}
