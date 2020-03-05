import 'package:flutter/material.dart';
import 'package:sevenclass/screens/join_class_screen.dart';

class ClassListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text('hello'),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Join class',
        onPressed: () {
          Navigator.push(context,
            MaterialPageRoute(builder: (context) => JoinClassScreen()
          ));
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
